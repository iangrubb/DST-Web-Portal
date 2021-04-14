defmodule PortalDeployment.Configuration.ClusterStorage do
  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.GameFiles.ClusterIni
  alias PortalDeployment.GameFiles.ClusterToken
  alias Ecto.Changeset

  @clusters_path "../game_files/clusters/"

  def cluster_path(id), do: @clusters_path <> id

  def all() do
    {:ok, cluster_ids} = File.ls(@clusters_path)

    cluster_ids |> Enum.map(&find!/1)
  end

  def find!(id) do
    {:ok, base_cluster} =
      %Cluster{}
      |> Changeset.change(%{id: id})
      |> Changeset.apply_action(:create)

    base_cluster
    |> Cluster.changeset(raw_cluster_data(id))
    |> Changeset.apply_action(:create)
    |> case do
      {:ok, cluster} -> cluster
    end
  end

  def save(%Cluster{id: id, cluster_token: cluster_token} = cluster) do
    ensure_directory(cluster)
    id |> cluster_path() |> ClusterIni.create_or_update(cluster)
    id |> cluster_path() |> ClusterToken.write(cluster_token)
  end

  defp ensure_directory(%Cluster{id: id}) do
    id |> cluster_path() |> File.mkdir_p()
  end

  defp raw_cluster_data(id) do
    with {:ok, cluster_token} <- ClusterToken.read(cluster_path(id)),
         {:ok, cluster_ini_data} <- ClusterIni.read(cluster_path(id)) do
      cluster_ini_data |> Map.put("cluster_token", cluster_token)
    end
  end
end
