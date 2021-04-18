defmodule PortalDeployment.Configuration.ClusterStorage do
  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ShardStorage
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.GameFiles.ClusterIni
  alias PortalDeployment.GameFiles.ClusterToken
  alias PortalDeployment.GameFiles.Helpers
  alias Ecto.Changeset

  @clusters_path "../game_files/clusters/"

  def cluster_path(id), do: @clusters_path <> id

  def all() do
    {:ok, cluster_ids} = File.ls(@clusters_path)

    cluster_ids |> Enum.map(&find/1)
    #update
  end

  def find(id) do
    case raw_cluster_data(id) do
      :error -> {:error, "cluster not found"}
      data ->
        %Cluster{}
        |> Changeset.change(%{id: id})
        |> Changeset.apply_action!(:create)
        |> Cluster.changeset(data)
        |> Changeset.apply_action(:create)
    end
  end

  def save(%Cluster{id: id, cluster_token: cluster_token} = cluster) do
    ensure_cluster_directory(id)
    cluster_path(id) |> ClusterIni.create_or_update(cluster)
    cluster_path(id) |> ClusterToken.write(cluster_token)
    Cluster.shards(cluster) |> Enum.each(fn %Shard{id: shard_id} = shard ->
      shard
      |> Shard.check_whether_master(cluster.master_shard.id)
      |> ShardStorage.save_to(cluster_path(id))
    end)
    delete_unused_shards(id, Cluster.shards(cluster))
  end

  defp delete_unused_shards(id, shards) do
    cluster_path(id)
    |> Helpers.directories()
    |> Enum.reject(fn {dir_name, _dir_path} ->
      shards
      |> Enum.map(fn shard -> shard.id end)
      |> Enum.member?(dir_name)
    end)
    |> Enum.each(fn {_dir_name, dir_path} -> File.rm_rf!(dir_path) end)
  end

  defp ensure_cluster_directory(id) do
    id |> cluster_path() |> File.mkdir_p()
  end

  defp raw_cluster_data(id) do
    with {:ok, cluster_token} <- ClusterToken.read(cluster_path(id)),
         {:ok, cluster_ini_data} <- ClusterIni.read(cluster_path(id)) do
      cluster_ini_data |> Map.put("cluster_token", cluster_token)
    else
      _ -> :error
    end
  end
end
