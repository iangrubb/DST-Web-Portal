defmodule PortalDeployment.Runtime.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :cluster_id, :string
    field :shard_count, :integer
  end

  def new(params) do
    {:ok, session} = %__MODULE__{} |> changeset(params) |> apply_action(:create)
    session
  end

  def changeset(session, params) do
    session
    |> cast(params, [:cluster_id, :shard_count])
    |> validate_required([:cluster_id, :shard_count])
  end
end
