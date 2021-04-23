defmodule PortalDeployment.Configuration.Shard do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string, default: "My_New_Shard"
    field :location, :string, default: "forest"
    # Helper field--source of truth is location in cluster
    field :is_master, :boolean
  end

  def changeset(server, params) do
    server
    |> cast(params, [:id, :name, :location, :is_master])
    |> validate_inclusion(:location, ["forest", "cave"])
    |> ensure_id()
  end

  def check_whether_master(%__MODULE__{id: id} = shard, master_shard_id) do
    {:ok, shard} =
      shard |> changeset(%{is_master: id == master_shard_id}) |> apply_action(:update)

    shard
  end

  defp ensure_id(%Ecto.Changeset{changes: %{id: id}, data: %__MODULE__{id: nil}} = changeset) do
    changeset |> change(%{id: id})
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{id: nil}} = changeset) do
    changeset |> change(%{id: Ecto.UUID.generate()})
  end

  defp ensure_id(changeset), do: changeset
end
