defmodule PortalDeployment.GameFileSystem.WorldGenOverrideLua do
  alias PortalDeployment.GameFileSystem.ShardFolder

  def path(cluster_id, shard_id), do: ShardFolder.path(cluster_id, shard_id) <> "/worldgenoverride.lua"

end
