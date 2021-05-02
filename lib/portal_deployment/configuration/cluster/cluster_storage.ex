defmodule PortalDeployment.Configuration.ClusterStorage do
  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ShardStorage
  alias PortalDeployment.Configuration.ClusterGenStorage
  alias PortalDeployment.Configuration.ConnectionsStorage
  alias PortalDeployment.GameFileSystem.ClusterIni
  alias PortalDeployment.GameFileSystem.ClusterToken
  alias PortalDeployment.GameFileSystem.ShardFolder
  alias PortalDeployment.GameFileSystem.ClusterFolder
  alias PortalDeployment.GameFileSystem.ClustersFolder
  alias PortalDeployment.GameFileSystem.ModsFolder
  alias PortalDeployment.GameFileSystem.ModSetupLua

  def all(), do: ClustersFolder.cluster_ids() |> Enum.map(&get!/1)

  def find(id) do
    case ClustersFolder.has_cluster?(id) do
      true -> {:ok, get!(id)}
      false -> {:error, "cluster not found"}
    end
  end

  def save(%Cluster{id: id, cluster_token: cluster_token, connections: connections, cluster_gen: cluster_gen} = cluster) do
    ClusterFolder.ensure(id)
    ClusterIni.create_or_update(id, cluster)
    ClusterToken.write(id, cluster_token)
    
    Cluster.shards(cluster) |> Enum.each(&ShardStorage.save/1)
    delete_unused_shards(id, Cluster.shards(cluster))

    ClusterGenStorage.save(id, cluster.master_shard.id, cluster.master_shard.world_gen, cluster_gen)

    ModsFolder.ensure(id)
    ModSetupLua.write_default(id)

    ConnectionsStorage.save(id, Cluster.shards(cluster), connections)
  end

  def delete(%Cluster{id: id}) do
    ClusterFolder.delete(id)
    id
  end

  defp get!(id) do
    {master_shard, dependent_shards} = raw_shards_data(id)
    connections = ConnectionsStorage.get_raw_data(id, master_shard["id"])
    cluster_gen = ClusterGenStorage.get(id, master_shard["id"])

    raw_data!(id)
    |> Map.put("master_shard", master_shard)
    |> Map.put("dependent_shards", dependent_shards)
    |> Map.put("id", id)
    |> Map.put("connections", connections)
    |> Map.put("cluster_gen", cluster_gen)
    |> Cluster.new!()
  end

  defp raw_shards_data(id) do
    ClusterFolder.shard_ids(id)
    |> Enum.map(fn shard_id -> ShardStorage.raw_data!(id, shard_id) end)
    |> Enum.reduce({nil, []}, fn
      %{"is_master" => "true"} = shard, {nil, deps} -> {shard, deps}
      %{"is_master" => "false"} = shard, {master, deps} -> {master, [shard | deps]}
      _shard, {master, deps} -> {master, deps}
    end)
  end

  defp delete_unused_shards(id, shards) do
    ClusterFolder.shard_ids(id)
    |> Enum.reject(fn shard_id ->
      Enum.any?(shards, fn shard -> shard.id == shard_id end)
    end)
    |> Enum.each(fn shard_id -> ShardFolder.delete(id, shard_id) end)
  end

  defp raw_data!(id) do
    cluster_token = ClusterToken.read!(id)
    cluster_ini_data = ClusterIni.read!(id)

    Map.put(cluster_ini_data, "cluster_token", cluster_token)
  end
end
