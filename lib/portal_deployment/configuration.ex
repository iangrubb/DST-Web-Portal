defmodule PortalDeployment.Configuration do
  @moduledoc """
  The context responsible for cluster configuration.
  """

  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ClusterStorage

  def list_clusters, do: ClusterStorage.all()

  def get_cluster(id), do: ClusterStorage.find(id)

  def test() do
    {:ok, c} = get_cluster("525f9233-6297-48f6-8237-44a8668adef9")
    c
    # c.master_shard.world_gen
    # create_cluster(%{
    #   "cluster_gen" => %{ "summer" => "longseason" },
    #   "master_shard" => %{ "world_gen" => %{ "location" => "cave", "monkey" => "insane"} }
    # })
  end

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
