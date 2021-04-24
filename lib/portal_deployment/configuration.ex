defmodule PortalDeployment.Configuration do
  @moduledoc """
  The context responsible for cluster configuration.
  """

  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ClusterStorage

  def list_clusters do

  end

  def get_cluster(id), do: ClusterStorage.find(id)

  def create_cluster(params \\ %{}) do
    with {:ok, cluster} <- Cluster.new(params) do
      ClusterStorage.save(cluster)
      {:ok, cluster}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  # TODO
    
  # Implement cluster_update and cluster_delete (for now don't worry about how this works on live clusters)

  # Check that running multiple clusters at once works, with different numbers of shards

  # Refactor

  def update_cluster(id, params) do
    with {:ok, cluster} <- get_cluster(id),
      {:ok, cluster} <- Cluster.update(cluster, params) do
        ClusterStorage.save(cluster)
        cluster
      else
        error_tuple -> error_tuple
      end
  end

  def delete_cluster(id) do
    with {:ok, cluster} <- get_cluster(id) do
      {:ok, ClusterStorage.delete(cluster)}
    else
      error_tuple -> error_tuple
    end
  end
end
