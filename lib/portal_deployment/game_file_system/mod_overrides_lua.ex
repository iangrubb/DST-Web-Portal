defmodule PortalDeployment.GameFileSystem.ModOverridesLua do
  alias PortalDeployment.GameFileSystem.ShardFolder

  def path(cluster_id, shard_id), do: ShardFolder.path(cluster_id, shard_id) <> "/modoverrides.lua"

  def write(cluster_id, shard_id, mod_map) do
    content = "return {\n" <> (mod_map |> Enum.map(&mod_text/1) |> Enum.join(",\n")) <> "\n}"

    path(cluster_id, shard_id) |> File.write(content)
  end

  def read!(cluster_id, shard_id), do: path(cluster_id, shard_id) |> File.read!() |> parse_file()

  # Assumes proper indentation, so don't let anyone else write this file.
  def parse_file(contents) do
    {data_map, nil} =
      contents
      |> String.split("\n")
      |> Enum.reduce({%{}, nil}, fn
        # Start processing a new mod
        "  [\"workshop-" <> rest, {data_map, nil} -> {data_map, rest |> String.split("\"") |> Enum.at(0)}
        # Start recording config options
        "    configuration_options = {", {data_map, key} -> {data_map, key, ""}
        # Stop recording config options
        "    }", {data_map, key, text} -> {Map.put(data_map, key, text), nil}
        # Collect lines within config options (no new line)
        line, {data_map, key, ""} -> {data_map, key, line}
        # Collect lines within config options
        line, {data_map, key, text} -> {data_map, key, text <> "\n" <> line}
        # Ignore extra lines
        line, acc -> acc
      end)

    data_map
  end

  defp mod_text({key, config_options_text}) do
    """
      ["workshop-#{key}"] = {
        enabled = true,
        configuration_options = {
    #{config_options_text}
        }
      }
    """
    |> String.trim("\n")
  end
end