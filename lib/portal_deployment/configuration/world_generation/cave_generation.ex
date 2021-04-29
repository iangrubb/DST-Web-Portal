defmodule PortalDeployment.Configuration.CaveGeneration do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    
  end

  def changeset(gen, params) do
    gen
    |> cast(params, [])
  end
end
