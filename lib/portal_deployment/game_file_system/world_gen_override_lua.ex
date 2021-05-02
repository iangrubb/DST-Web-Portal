defmodule PortalDeployment.GameFileSystem.WorldGenOverrideLua do
  alias PortalDeployment.GameFileSystem.ShardFolder
  alias PortalDeployment.Utils.FileSystem

  def path(cluster_id, shard_id),
    do: ShardFolder.path(cluster_id, shard_id) <> "/worldgenoverride.lua"

  def read(cluster_id, shard_id) do
    path(cluster_id, shard_id)
    |> FileSystem.read_with_backup("")
    |> parse_content()
  end

  def create_or_update_forest(cluster_id, shard_id, gen) do  
    content = write_gen_lines(cluster_id, shard_id, gen) |> forest_template()
      
    path(cluster_id, shard_id) |> File.write!(content)
  end

  def create_or_update_cave(cluster_id, shard_id, gen) do
    content = write_gen_lines(cluster_id, shard_id, gen) |> cave_template()

    path(cluster_id, shard_id) |> File.write!(content)
  end

  defp write_gen_lines(cluster_id, shard_id, gen) do
    read(cluster_id, shard_id)
    |> Map.delete("location")
    |> Map.merge(gen)
    |> Enum.map(fn
        {key, "default"} -> ""
        {key, value} -> "    " <> key <> "=" <> value
      end)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.join("\n")
  end

  defp parse_content(""), do: %{}

  defp parse_content(content) do
    content
    |> String.split("\n")
    |> Enum.map(fn str -> String.split(str, "=") end)
    |> Enum.reduce(%{ "location" => "forest"}, fn
      [line], acc -> acc
      ["  override_enabled", _], acc -> acc
      ["  overrides", _], acc -> acc
      ["  preset", _], acc -> Map.put(acc, "location", "cave")
      [key | value], acc -> Map.put(acc, String.trim(key), (value |> Enum.join(" ") |> String.trim()))
    end)
  end

  defp forest_template(lines) do
    """
    return {
      override_enabled=true,
      overrides={
    #{lines}
      },
    }
    """
  end

  defp cave_template(lines) do
    """
    return {
      preset="DST_CAVE",
      override_enabled=true,
      overrides={
    #{lines}
      },
    }
    """
  end
end
