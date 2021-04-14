defmodule PortalDeployment.Configuration do
  @moduledoc """
  The context responsible for cluster configuration.
  """

  alias PortalDeployment.Configuration.Cluster
  alias PortalDeployment.Configuration.ClusterStorage

  alias PortalDeployment.Configuration.ShardCollection

  def create_cluster() do
    # {:ok, cluster} =

      # |> ClusterStorage.create()

    # cluster

    case Cluster.new() do
      {:ok, cluster} ->
        # ClusterStorage.save(cluster)

        # [%{is_master: true, location: "forest"}, %{is_master: false, location}]

        ShardCollection.new(%{"cluster_id" => cluster.id})

      {:error, changeset} -> changeset
    end
  end



  @doc """
  Returns the list of clusters.

  ## Examples

      iex> list_clusters()
      [%Cluster{}, ...]

  """
  def list_clusters do
    raise "TODO"
  end

  def get_cluster!(id) do
  end

  # def create_cluster(cluster_params) do
  #   # should be able to create a default cluster if just a name is given (maybe even can use a default name?)

  #   # Maybe don't use a file name at all. Use a UUID and for display purposes just reach in and show the shard name.

  #   # should be able to pass topology options to set up custom number of shards.

  #   Cluster.new()
  # end

  def delete_cluster(id) do
  end
end
