defmodule PortalDeployment.Configuration.Shard do
  use Ecto.Schema
  import Ecto.Changeset
  alias PortalDeployment.Utils.Changeset, as: ChangesetUtils

  # Whether this has a forest or cav location depends on what's going on in the worldgen file

  @primary_key {:id, :string, []}
  embedded_schema do
    field :name, :string, default: "My_New_Shard"
    field :location, :string, default: "forest"
    field :cluster_id, :string
    field :is_master, :boolean
  end

  def changeset(shard, params) do
    shard
    |> cast(params, [:id, :cluster_id, :name, :location, :is_master])
    # |> ChangesetUtils.ensure_uuid_for_key(:id)
    |> validate_inclusion(:location, ["forest", "cave"])
  end

  def cluster_nested_changeset(shard, params, parent_params) do
    total_params = Map.merge(params, parent_params)

    changeset(shard, total_params)
  end
end
