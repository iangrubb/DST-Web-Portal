defmodule PortalDeployment.Repo do
  use Ecto.Repo,
    otp_app: :portal_deployment,
    adapter: Ecto.Adapters.Postgres
end
