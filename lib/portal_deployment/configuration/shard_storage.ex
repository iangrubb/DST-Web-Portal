defmodule PortalDeployment.Configuration.ShardStorage do
  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.GameFiles.ServerIni

  def save_to(%Shard{id: id} = shard, path) do
    ensure_shard_directory(path, id)
    shard_path_extension(path, id) |> ServerIni.create_or_update(shard)
  end

  defp shard_path_extension(base_path, id) do
    base_path <> "/" <> id
  end

  defp ensure_shard_directory(base_path, id) do
    shard_path_extension(base_path, id) |> IO.inspect() |> File.mkdir_p()
  end
end