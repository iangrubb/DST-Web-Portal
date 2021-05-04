defmodule PortalDeploymentWeb.UserSessionController do
  use PortalDeploymentWeb, :controller

  alias PortalDeployment.Access

  action_fallback PortalDeploymentWeb.FallbackController

  def show(conn, _params) do
    case get_session(conn, :login_token) do
      nil -> render(conn, "show.json", %{user_session: nil})
      token ->
        case Access.valid_login_token?(token) do
          true -> render(conn, "show.json", %{user_session: %{access_token: Access.create_auth_token()}})
          false -> render(conn, "show.json", %{user_session: nil})
        end
    end
  end

  def create(conn, %{"password" => password}) do
    case Access.valid_credentials?(password) do
      true ->
        conn
        |> add_login_token_to_session()
        |> render("show.json", %{user_session: %{access_token: Access.create_auth_token()}})

      false ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("show.json", %{user_session: nil})
    end
  end

  defp add_login_token_to_session(conn) do
    put_session(conn, :login_token, Access.create_login_token())
  end
end
