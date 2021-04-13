defmodule PortalDeployment.Configuration.ServerStorage do
  alias PortalDeployment.Configuration.Server
  alias PortalDeployment.Configuration.ClusterStorage
  alias Ecto.Changeset

  def all_for_cluster(cluster_id) do

  end

  def find(cluster_id, server_id) do

  end

  def create(%Changeset{data: %Server{}} = changeset), do: mutate(changeset, :insert)

  def update(%Changeset{data: %Server{}} = changeset), do: mutate(changeset, :update)

  defp mutate(%Changeset{data: %Server{}} = changeset, action) do
    case Changeset.apply_action(changeset, action) do
      {:ok, server} ->
        save(server)
        {:ok, server}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp save(%Server{} = server) do
    ensure_directory(server)
    put_server_ini(server)
  end

  defp server_path(cluster_id, server_id) do
    ClusterStorage.cluster_path(cluster_id) <> "/" <> server_id
  end

  defp server_ini_path(cluster_id, server_id) do
    server_path(cluster_id, server_id) <> "/server.ini"
  end

  defp ensure_directory(%Server{id: id, cluster_id: cluster_id} = server) do
    server_path(cluster_id, id) |> File.mkdir_p()
  end

  defp put_server_ini(%Server{id: id, cluster_id: cluster_id} = server) do
    server_ini_path(cluster_id, id) |> File.write!(server_ini_template(server))
  end

  defp server_ini_template(%Server{} = server) do
    """
    [NETWORK]
    server_port = 10998

    [SHARD]
    is_master = #{server.is_master}
    name = #{server.name}
    id = #{server.id}

    [ACCOUNT]
    encode_user_path = true

    [STEAM]
    master_server_port = 27017
    authentication_port = 8767
    """
  end

  defp read_server_data(cluster_id, server_id) do

  end
end
