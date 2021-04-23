defmodule PortalDeployment.Configuration.ShardStorage do
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.GameFiles.ServerIni
  alias PortalDeployment.GameFiles.Helpers

  def shard_path_extension(cluster_path, id), do: cluster_path <> "/" <> id

  def save_to(%Shard{id: id} = shard, path) do
    ensure_shard_directory(path, id)
    shard_path_extension(path, id) |> ServerIni.create_or_update(shard)
  end

  def raw_shards_data(path) do
    path
    |> Helpers.directories()
    |> Enum.map(fn {_shard_id, full_path} -> raw_shard_data(full_path) end)
  end

  def raw_shard_data(path) do
    {:ok, data} = ServerIni.read(path)
    data
  end

  defp ensure_shard_directory(base_path, id) do
    shard_path_extension(base_path, id) |> File.mkdir_p()
  end
end
