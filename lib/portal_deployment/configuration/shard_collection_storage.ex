defmodule PortalDeployment.Configuration.ShardCollectionStorage do
  alias PortalDeployment.Configuration.ShardCollection
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.Configuration.ClusterStorage
  alias PortalDeployment.GameFiles.ServerIni
  alias PortalDeployment.GameFiles.Helpers

  def save(%ShardCollection{cluster_id: cluster_id, master_shard: master_shard} = shard_collection) do
    shards = shard_collection |> ShardCollection.shards()

    save_shards(cluster_id, shards, master_shard)
    delete_unused_shards(cluster_id, shards)
  end

  def shard_path(cluster_id, shard_id) do
    ClusterStorage.cluster_path(cluster_id) <> "/" <> shard_id
  end

  defp save_shards(cluster_id, shards, master_shard) do
    shards
    |> Enum.each(fn %Shard{id: id} = shard ->
      ensure_shard_directory(cluster_id, id)

      shard_contents = Map.put(shard, :is_master, id == master_shard.id)

      shard_path(cluster_id, id)
      |> ServerIni.create_or_update(shard_contents)
    end)
  end

  defp delete_unused_shards(cluster_id, shards) do
    ClusterStorage.cluster_path(cluster_id)
    |> Helpers.directories()
    |> Enum.reject(fn dir ->
      shards
      |> Enum.map(fn shard -> shard.id end)
      |> Enum.member?(dir)
    end)
    |> Enum.map(fn shard_id -> shard_path(cluster_id, shard_id) end)
    |> Enum.each(&File.rm_rf!/1)
  end

  defp ensure_shard_directory(cluster_id, shard_id) do
    shard_path(cluster_id, shard_id) |> File.mkdir_p()
  end
end
