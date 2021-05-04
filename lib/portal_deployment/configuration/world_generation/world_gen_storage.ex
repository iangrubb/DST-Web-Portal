defmodule PortalDeployment.Configuration.WorldGenStorage do
  alias PortalDeployment.Configuration.ForestGen
  alias PortalDeployment.Configuration.CaveGen
  alias PortalDeployment.GameFileSystem.WorldGenOverrideLua

  def save(cluster_id, shard_id, %ForestGen{} = gen) do
    gen = stringify_gen(gen)
    WorldGenOverrideLua.create_or_update_forest(cluster_id, shard_id, gen)
  end

  def save(cluster_id, shard_id, %CaveGen{} = gen) do
    gen = stringify_gen(gen)
    WorldGenOverrideLua.create_or_update_cave(cluster_id, shard_id, gen)
  end

  def get!(cluster_id, shard_id) do
    WorldGenOverrideLua.read(cluster_id, shard_id)
    |> Map.update("ocean_seastack", "default", fn value ->
      value |> String.split("_") |> Enum.at(1)
    end)
    |> Map.update("ocean_waterplant", "default", fn value ->
      value |> String.split("_") |> Enum.at(1)
    end)
  end

  defp stringify_gen(gen) do
    gen
    |> Map.to_list()
    |> Enum.reduce(%{}, fn
      {:__struct__, _}, acc ->
        acc

      {:ocean_seastack, :default}, acc ->
        Map.put(acc, "ocean_seastack", "default")

      {:ocean_seastack, value}, acc ->
        Map.put(acc, "ocean_seastack", "ocean_" <> Atom.to_string(value))

      {:ocean_waterplant, :default}, acc ->
        Map.put(acc, "ocean_waterplant", "default")

      {:ocean_waterplant, value}, acc ->
        Map.put(acc, "ocean_waterplant", "ocean_" <> Atom.to_string(value))

      {key, value}, acc ->
        Map.put(acc, Atom.to_string(key), Atom.to_string(value))
    end)
  end
end
