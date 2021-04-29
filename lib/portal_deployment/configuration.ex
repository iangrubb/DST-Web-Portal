defmodule PortalDeployment.Configuration do
  @moduledoc """
  The context responsible for cluster configuration.
  """

  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ClusterStorage

  def list_clusters, do: ClusterStorage.all()

  def get_cluster(id), do: ClusterStorage.find(id)
  
  def create_cluster(params \\ %{}) do
    with {:ok, cluster} <- Cluster.new(params) do
      ClusterStorage.save(cluster)
      {:ok, cluster}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update_cluster(id, params) do
    with {:ok, cluster} <- get_cluster(id),
         {:ok, cluster} <- Cluster.update(cluster, params) do
      ClusterStorage.save(cluster)
      {:ok, cluster}
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
