defmodule PortalDeploymentWeb.Router do
  use PortalDeploymentWeb, :router

  alias PortalDeployment.Access

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :authenticate do
    plug :check_auth_token
  end

  scope "/api", PortalDeploymentWeb do
    pipe_through :api

    resources "/user_sessions", UserSessionController, only: [:show, :create], singleton: true
  end

  scope "/api", PortalDeploymentWeb do
    pipe_through [:api, :authenticate]

    get "/", ClusterController, :hello

    resources "/game_sessions", SessionController, only: [:index, :create, :delete]

    resources "/clusters", ClusterController, only: [:index, :show, :create, :delete] do
      resources "/servers", ServerController, only: [:index, :show, :update]
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PortalDeploymentWeb.Telemetry
    end
  end

  def check_auth_token(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         true <- Access.valid_auth_token?(token) do
      conn
    else
      _ ->
        conn
        |> delete_session(:login_token)
        |> send_resp(401, "Unauthorized")
        |> halt()
    end
  end
end
