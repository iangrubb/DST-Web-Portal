defmodule PortalDeployment.ConfigurationTest do
  use PortalDeployment.DataCase

  alias PortalDeployment.Configuration

  describe "servers" do
    alias PortalDeployment.Configuration.Server

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def server_fixture(attrs \\ %{}) do
      {:ok, server} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configuration.create_server()

      server
    end

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Configuration.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Configuration.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      assert {:ok, %Server{} = server} = Configuration.create_server(@valid_attrs)
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      assert {:ok, %Server{} = server} = Configuration.update_server(server, @update_attrs)
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Configuration.update_server(server, @invalid_attrs)
      assert server == Configuration.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Configuration.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Configuration.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Configuration.change_server(server)
    end
  end
end
