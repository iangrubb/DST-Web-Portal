defmodule PortalDeploymentWeb.ClusterControllerTest do
  use PortalDeploymentWeb.ConnCase

  alias PortalDeployment.Clusters
  alias PortalDeployment.Clusters.Cluster

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:cluster) do
    {:ok, cluster} = Clusters.create_cluster(@create_attrs)
    cluster
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clusters", %{conn: conn} do
      conn = get(conn, Routes.cluster_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cluster" do
    test "renders cluster when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cluster_path(conn, :create), cluster: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cluster_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cluster_path(conn, :create), cluster: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cluster" do
    setup [:create_cluster]

    test "renders cluster when data is valid", %{conn: conn, cluster: %Cluster{id: id} = cluster} do
      conn = put(conn, Routes.cluster_path(conn, :update, cluster), cluster: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cluster_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cluster: cluster} do
      conn = put(conn, Routes.cluster_path(conn, :update, cluster), cluster: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cluster" do
    setup [:create_cluster]

    test "deletes chosen cluster", %{conn: conn, cluster: cluster} do
      conn = delete(conn, Routes.cluster_path(conn, :delete, cluster))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cluster_path(conn, :show, cluster))
      end
    end
  end

  defp create_cluster(_) do
    cluster = fixture(:cluster)
    %{cluster: cluster}
  end
end
