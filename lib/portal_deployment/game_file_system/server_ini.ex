defmodule PortalDeployment.GameFileSystem.ServerIni do
  alias PortalDeployment.GameFileSystem.ShardFolder
  alias PortalDeployment.Utils.FileSystem

  def path(cluster_id, shard_id), do: ShardFolder.path(cluster_id, shard_id) <> "/server.ini"

  def create_or_update(cluster_id, shard_id, data) do
    new_content =
      path(cluster_id, shard_id)
      |> FileSystem.read_with_backup(template())
      |> FileSystem.update_ini_file_contents(data)

    path(cluster_id, shard_id) |> File.write!(new_content)
  end

  def read!(cluster_id, shard_id),
    do: path(cluster_id, shard_id) |> File.read!() |> FileSystem.convert_ini_file_to_hash()

  defp template() do
    """
    [NETWORK]
    server_port = 

    [SHARD]
    is_master = 
    name = 
    id = 

    [ACCOUNT]
    encode_user_path = true

    [STEAM]
    master_server_port = 
    authentication_port = 
    """
  end
end
