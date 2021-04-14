defmodule PortalDeployment.Configuration.Shard do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string, default: "My_New_Shard"
    field :location, :string, default: "forest"
  end

  def changeset(server, params) do
    server
    |> cast(params, [:name, :location])
    |> validate_inclusion(:location, ["forest", "cave"])
    |> ensure_id()
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{id: nil}} = changeset) do
    changeset |> change(%{id: Ecto.UUID.generate()})
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{}} = changeset), do: changeset
end
