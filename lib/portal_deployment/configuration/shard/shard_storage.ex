defmodule PortalDeployment.Configuration.ShardStorage do
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.GameFileSystem.ServerIni
  alias PortalDeployment.GameFileSystem.ShardFolder

  def save(%Shard{id: id, cluster_id: cluster_id} = shard) do
    ShardFolder.ensure(cluster_id, id)
    ServerIni.create_or_update(cluster_id, id, shard)
  end

  def raw_data!(cluster_id, shard_id), do: ServerIni.read!(cluster_id, shard_id)
end
