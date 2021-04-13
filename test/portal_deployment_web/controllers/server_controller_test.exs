defmodule PortalDeploymentWeb.ServerControllerTest do
  use PortalDeploymentWeb.ConnCase

  alias PortalDeployment.Configuration
  alias PortalDeployment.Configuration.Server

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:server) do
    {:ok, server} = Configuration.create_server(@create_attrs)
    server
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all servers", %{conn: conn} do
      conn = get(conn, Routes.server_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create server" do
    test "renders server when data is valid", %{conn: conn} do
      conn = post(conn, Routes.server_path(conn, :create), server: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.server_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.server_path(conn, :create), server: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update server" do
    setup [:create_server]

    test "renders server when data is valid", %{conn: conn, server: %Server{id: id} = server} do
      conn = put(conn, Routes.server_path(conn, :update, server), server: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.server_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, server: server} do
      conn = put(conn, Routes.server_path(conn, :update, server), server: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete server" do
    setup [:create_server]

    test "deletes chosen server", %{conn: conn, server: server} do
      conn = delete(conn, Routes.server_path(conn, :delete, server))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.server_path(conn, :show, server))
      end
    end
  end

  defp create_server(_) do
    server = fixture(:server)
    %{server: server}
  end
end
