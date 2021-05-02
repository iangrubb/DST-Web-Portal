defmodule PortalDeployment.Configuration.ClusterGenStorage do
  alias PortalDeployment.Configuration.ForestGen
  alias PortalDeployment.Configuration.CaveGen
  alias PortalDeployment.Configuration.ClusterGen
  alias PortalDeployment.GameFileSystem.WorldGenOverrideLua
  
  def save(cluster_id, master_shard_id, %ForestGen{}, gen) do
    gen = gen |> stringify_gen

    WorldGenOverrideLua.create_or_update_forest(cluster_id, master_shard_id, gen)
  end

  def save(cluster_id, master_shard_id, %CaveGen{}, gen) do
    gen = gen |> stringify_gen

    WorldGenOverrideLua.create_or_update_cave(cluster_id, master_shard_id, gen)
  end

  def get(cluster_id, shard_id) do
    WorldGenOverrideLua.read(cluster_id, shard_id)
  end

  defp stringify_gen(gen) do
    gen
    |> Map.to_list()
    |> Enum.reduce(%{}, fn
      {:__struct__, _}, acc -> acc
      {key, value}, acc -> Map.put(acc, Atom.to_string(key), Atom.to_string(value))
    end)
  end
end
