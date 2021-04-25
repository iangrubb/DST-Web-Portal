defmodule PortalDeployment.GameFileSystem.ClusterFolder do
  alias PortalDeployment.GameFileSystem.ClustersFolder
  alias PortalDeployment.Utils.FileSystem

  def path(id), do: ClustersFolder.path() <> "/" <> id

  def shard_ids(id) do
    path(id)
    |> FileSystem.directories()
    |> Enum.filter(fn dir_name -> dir_name != "mods" end)
  end

  def ensure(id), do: id |> path() |> File.mkdir_p()

  def delete(id), do: id |> path() |> File.rm_rf!()
end
