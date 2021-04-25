defmodule PortalDeployment.GameFileSystem.ModsFolder do
  alias PortalDeployment.GameFileSystem.ClusterFolder

  def path(id), do: ClusterFolder.path(id) <> "/mods"

  def ensure(id), do: id |> path() |> File.mkdir_p()
end
