defmodule PortalDeployment.GameFileSystem.ClustersFolder do
  alias PortalDeployment.GameFileSystem.TopLevelFolder

  def path(), do: TopLevelFolder.path() <> "/clusters"

  def cluster_ids, do: path() |> File.ls!()

  def has_cluster?(cluster_id), do: cluster_ids() |> Enum.member?(cluster_id)
end
