defmodule PortalDeployment.Runtime.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :cluster_id, :string
  end

  def new(cluster_id) do
    {:ok, session} = %__MODULE__{} |> changeset(%{cluster_id: cluster_id}) |> apply_action(:create)
    session
  end

  def changeset(session, params) do
    session
    |> cast(params, [:cluster_id])
  end
end
