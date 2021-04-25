defmodule PortalDeployment.GameFileSystem.ShardFolder do
  alias PortalDeployment.GameFileSystem.ClusterFolder

  def path(cluster_id, shard_id), do: ClusterFolder.path(cluster_id) <> "/" <> shard_id

  def ensure(cluster_id, shard_id), do: path(cluster_id, shard_id) |> File.mkdir_p()

  def delete(cluster_id, shard_id), do: path(cluster_id, shard_id) |> File.rm_rf!()
end
