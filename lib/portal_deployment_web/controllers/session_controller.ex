defmodule PortalDeploymentWeb.SessionController do
  use PortalDeploymentWeb, :controller

  alias PortalDeployment.Runtime

  action_fallback PortalDeploymentWeb.FallbackController

  def index(conn, _params) do
    # sessions = Runtime.list_sessions()
    # render(conn, "index.json", sessions: sessions)
  end

  def create(conn, %{"session" => session_params}) do
    # with {:ok, %Session{} = session} <- Runtime.create_session(session_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.session_path(conn, :show, session))
    #   |> render("show.json", session: session)
    # end
  end

  def delete(conn, %{"id" => id}) do

  end
  #   session = Runtime.get_session!(id)

  #   with {:ok, %Session{}} <- Runtime.delete_session(session) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
