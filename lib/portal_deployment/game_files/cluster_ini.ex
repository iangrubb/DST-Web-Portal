defmodule PortalDeployment.GameFiles.ClusterIni do
  def read(base_path) do
    base_path
    |> cluster_ini_path()
    |> File.read()
    |> case do
      {:ok, contents} -> {:ok, convert_to_hash(contents)}
      {:error, reason} -> {:error, reason}
    end
  end

  def create_or_update(base_path, data) do
    new_content =
      base_path
      |> cluster_ini_path()
      |> File.read()
      |> case do
        {:ok, contents} -> contents
        {:error, _reason} -> template()
      end
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, "=") end)
      |> Enum.map(fn
        [line] -> line

        [key_str | value] ->
          key = key_str |> String.trim() |> String.to_atom()

          case Map.get(data, key) do
            nil -> Enum.join([key_str | value], "=")
            update -> "#{key_str}= #{update}"
          end
      end)
      |> Enum.join("\n")

    base_path
    |> cluster_ini_path()
    |> File.write!(new_content)
  end

  defp convert_to_hash(file) do
    file
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, "=") end)
    |> Enum.reduce(%{}, fn
      [_line], acc -> acc
      [key | value], acc ->
        value = value |> Enum.join("=") |> String.trim()
        Map.put(acc, String.trim(key), value)
    end)
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
