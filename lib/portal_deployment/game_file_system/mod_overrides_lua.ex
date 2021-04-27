defmodule PortalDeployment.GameFileSystem.ModOverridesLua do
  alias PortalDeployment.GameFileSystem.ShardFolder

  def path(cluster_id, shard_id), do: ShardFolder.path(cluster_id, shard_id) <> "/modoverrides.lua"

  # This may need refactoring to something more efficient than "read all then write all" once mod support is added

  def write(cluster_id, shard_id, mod_map) do
    content = "return {\n" <> (mod_map |> Enum.map(&mod_text/1) |> Enum.join(",\n")) <> "\n}"

    path(cluster_id, shard_id) |> File.write(content)
  end

  def mod_text({key, config_options_text}) do
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