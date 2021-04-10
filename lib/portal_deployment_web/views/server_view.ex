defmodule PortalDeploymentWeb.ServerView do
  use PortalDeploymentWeb, :view
  alias PortalDeploymentWeb.ServerView

  def render("index.json", %{servers: servers}) do
    %{data: render_many(servers, ServerView, "server.json")}
  end

  def render("show.json", %{server: server}) do
    %{data: render_one(server, ServerView, "server.json")}
  end

  def render("server.json", %{server: server}) do
    %{id: server.id}
  end
end
