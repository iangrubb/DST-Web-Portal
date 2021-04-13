defmodule PortalDeployment.Configuration.Server do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :is_master, :boolean, default: false
    field :name, :string, default: "MyNewShard"
    field :cluster_id, :string

    # world gen config info
  end

  def changeset(server, params) do
    server
    |> cast(params, [:is_master, :name, :cluster_id])
    |> validate_required(:cluster_id)
    |> ensure_id()
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{id: nil}} = changeset) do
    changeset |> change(%{id: Ecto.UUID.generate()})
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{}} = changeset), do: changeset
end
