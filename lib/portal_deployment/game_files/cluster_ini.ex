defmodule PortalDeployment.GameFiles.ClusterIni do
  alias PortalDeployment.GameFiles.Helpers

  def read(base_path) do
    base_path
    |> cluster_ini_path()
    |> File.read()
    |> case do
      {:ok, contents} -> {:ok, Helpers.convert_ini_file_to_hash(contents)}
      {:error, reason} -> {:error, reason}
    end
  end

  def create_or_update(base_path, data) do
    new_content =
      base_path
      |> Helpers.read_with_backup(template())
      |> Helpers.update_ini_file_contents(data)

    base_path
    |> cluster_ini_path()
    |> File.write!(new_content)
  end

  defp cluster_ini_path(base_path), do: base_path <> "/cluster.ini"

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
    master_port = 11000
    cluster_key =
    """
  end
end
