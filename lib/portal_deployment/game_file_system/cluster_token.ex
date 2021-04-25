defmodule PortalDeployment.GameFileSystem.ClusterToken do
  alias PortalDeployment.GameFileSystem.ClusterFolder

  def path(id), do: ClusterFolder.path(id) <> "/cluster_token.txt"

  def read!(id), do: id |> path() |> File.read!()

  def write(id, token), do: id |> path() |> File.write!(token)
end
