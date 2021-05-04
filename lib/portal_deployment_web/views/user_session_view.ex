defmodule PortalDeploymentWeb.UserSessionView do
  use PortalDeploymentWeb, :view
  alias PortalDeploymentWeb.UserSessionView

  def render("show.json", %{user_session: nil}) do
    render_one(%{}, UserSessionView, "error.json")
  end

  def render("show.json", %{user_session: user_session}) do
    render_one(user_session, UserSessionView, "user_session.json")
  end

  def render("user_session.json", %{user_session: user_session}) do
    %{access_token: user_session.access_token}
  end

  def render("error.json", _), do: %{}
end
