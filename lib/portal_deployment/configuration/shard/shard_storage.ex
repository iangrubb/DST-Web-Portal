defmodule PortalDeployment.Configuration.ShardStorage do
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.GameFileSystem.ServerIni
  alias PortalDeployment.GameFileSystem.ShardFolder
  alias PortalDeployment.Configuration.WorldGenStorage

  def save(%Shard{id: id, cluster_id: cluster_id, world_gen: world_gen} = shard) do
    ShardFolder.ensure(cluster_id, id)
    ServerIni.create_or_update(cluster_id, id, shard)
    WorldGenStorage.save(cluster_id, id, world_gen)
  end

  def raw_data!(cluster_id, shard_id) do
    ServerIni.read!(cluster_id, shard_id)
    |> Map.put("world_gen", WorldGenStorage.get!(cluster_id, shard_id))
  end
end
