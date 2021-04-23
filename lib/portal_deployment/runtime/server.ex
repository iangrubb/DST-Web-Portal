defmodule PortalDeployment.Runtime.Server do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :shard_id, :string
    field :port_slot, :integer
    # Helper field--source of truth is location in cluster
    field :is_master, :boolean
  end

  def new(params) do
    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:create)
  end

  def changeset(server, params) do
    server
    |> cast(params, [:shard_id, :port_slot, :is_master])
  end
end
