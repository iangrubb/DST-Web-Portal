defmodule PortalDeployment.ClustersTest do
  use PortalDeployment.DataCase

  alias PortalDeployment.Clusters

  describe "clusters" do
    alias PortalDeployment.Clusters.Cluster

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def cluster_fixture(attrs \\ %{}) do
      {:ok, cluster} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clusters.create_cluster()

      cluster
    end

    test "list_clusters/0 returns all clusters" do
      cluster = cluster_fixture()
      assert Clusters.list_clusters() == [cluster]
    end

    test "get_cluster!/1 returns the cluster with given id" do
      cluster = cluster_fixture()
      assert Clusters.get_cluster!(cluster.id) == cluster
    end

    test "create_cluster/1 with valid data creates a cluster" do
      assert {:ok, %Cluster{} = cluster} = Clusters.create_cluster(@valid_attrs)
    end

    test "create_cluster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clusters.create_cluster(@invalid_attrs)
    end

    test "update_cluster/2 with valid data updates the cluster" do
      cluster = cluster_fixture()
      assert {:ok, %Cluster{} = cluster} = Clusters.update_cluster(cluster, @update_attrs)
    end

    test "update_cluster/2 with invalid data returns error changeset" do
      cluster = cluster_fixture()
      assert {:error, %Ecto.Changeset{}} = Clusters.update_cluster(cluster, @invalid_attrs)
      assert cluster == Clusters.get_cluster!(cluster.id)
    end

    test "delete_cluster/1 deletes the cluster" do
      cluster = cluster_fixture()
      assert {:ok, %Cluster{}} = Clusters.delete_cluster(cluster)
      assert_raise Ecto.NoResultsError, fn -> Clusters.get_cluster!(cluster.id) end
    end

    test "change_cluster/1 returns a cluster changeset" do
      cluster = cluster_fixture()
      assert %Ecto.Changeset{} = Clusters.change_cluster(cluster)
    end
  end
end
