defmodule PortalDeploymentWeb.ServerController do
  use PortalDeploymentWeb, :controller

  alias PortalDeployment.Configuration
  alias PortalDeployment.Configuration.Server

  action_fallback PortalDeploymentWeb.FallbackController

  def index(conn, _params) do
    # servers = Configuration.list_servers()
    # render(conn, "index.json", servers: servers)
  end

  def show(conn, %{"id" => id}) do
    # server = Configuration.get_server!(id)
    # render(conn, "show.json", server: server)
  end

  def update(conn, %{"id" => id, "server" => server_params}) do
    # server = Configuration.get_server!(id)

    # with {:ok, %Server{} = server} <- Configuration.update_server(server, server_params) do
    #   render(conn, "show.json", server: server)
    # end
  end
end
