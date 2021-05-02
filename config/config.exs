# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :portal_deployment,
  ecto_repos: [PortalDeployment.Repo]

# Configures the endpoint
config :portal_deployment, PortalDeploymentWeb.Endpoint,
  http: [port: 4000],
  https: [port: 4001],
  url: [host: "localhost"],
  secret_key_base: "VksN82/lECIOXd5YI4Av3Y7hIXGhIOYv/aKDseXafdpqpkKEbS1F+98HKEc8uK91",
  render_errors: [view: PortalDeploymentWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PortalDeployment.PubSub,
  live_view: [signing_salt: "sicbrMQL"]

config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
