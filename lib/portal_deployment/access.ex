defmodule PortalDeployment.Access do
  @moduledoc """
  The Access context.
  """

  def valid_credentials?(password) do
    # Store server password in ENV variable
    password == "test"
  end

  def create_login_token(), do: create_token("login")

  def create_auth_token(), do: create_token("auth")

  def valid_login_token?(token), do: valid_token?("login", token)

  def valid_auth_token?(token), do: valid_token?("auth", token)

  defp valid_token?(type, token) do
    {:ok, true} == Phoenix.Token.verify(PortalDeploymentWeb.Endpoint, type, token, max_age: 60 * 40 * 24)
  end

  defp create_token(type) do
    Phoenix.Token.sign(PortalDeploymentWeb.Endpoint, type, true)
  end
end
