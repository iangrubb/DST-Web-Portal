defmodule PortalDeployment.GameFileSystem.ClustersFolder do
  @clusters_path "../game_files/clusters"

  def path(), do: @clusters_path

  def cluster_ids, do: path() |> File.ls!()

  def has_cluster?(cluster_id), do: cluster_ids() |> Enum.member?(cluster_id)
end
