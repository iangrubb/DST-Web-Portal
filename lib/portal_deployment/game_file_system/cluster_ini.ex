defmodule PortalDeployment.GameFileSystem.ClusterIni do
  alias PortalDeployment.GameFileSystem.ClusterFolder
  alias PortalDeployment.Utils.FileSystem

  def path(id), do: ClusterFolder.path(id) <> "/cluster.ini"

  def read!(id), do: path(id) |> File.read!() |> FileSystem.convert_ini_file_to_hash()

  def create_or_update(id, data) do
    new_content =
      path(id)
      |> FileSystem.read_with_backup(template())
      |> FileSystem.update_ini_file_contents(data)

    path(id) |> File.write!(new_content)
  end

  defp template() do
    """
    [GAMEPLAY]

    game_mode =
    max_players =
    pvp =
    pause_when_empty = true
    vote_enabled =

    [NETWORK]

    cluster_name =
    cluster_description =
    cluster_intention =
    cluster_password =
    tick_rate = 15

    [MISC]

    console_enabled = true

    [STEAM]

    steam_group_id =
    steam_group_only =
    steam_group_admins =

    [SHARD]

    shard_enabled = true
    bind_ip = 127.0.0.1
    master_ip = 127.0.0.1
    master_port = 
    cluster_key = 
    """
  end
end
