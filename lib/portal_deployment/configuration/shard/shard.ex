defmodule PortalDeployment.Configuration.Shard do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortalDeployment.Configuration.WorldGen
  alias PortalDeployment.Utils.Changeset, as: ChangesetUtils

  @primary_key {:id, :string, []}
  embedded_schema do
    field :world_gen, WorldGen
    field :name, :string, default: "My_New_Shard"
    field :cluster_id, :string
    field :is_master, :boolean
  end

  def changeset(shard, params) do
    shard
    |> cast(params, [:id, :cluster_id, :name, :is_master, :world_gen])
  end

  def cluster_nested_changeset(shard, params, parent_params) do
    total_params = Map.merge(params, parent_params)

    changeset(shard, total_params)
  end
end
