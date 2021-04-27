defmodule PortalDeployment.Configuration.Cluster do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortalDeployment.Configuration.Shard
  alias PortalDeployment.Configuration.Connections
  alias PortalDeployment.Utils.Changeset, as: ChangesetUtils

  # Test what happens if unrecognized ids show up in the Connection struct, may have to validate that

  embedded_schema do
    embeds_one :master_shard, Shard
    embeds_many :dependent_shards, Shard
    embeds_one :connections, Connections
    field :cluster_name, :string, default: "My_New_Cluster"
    field :cluster_description, :string, default: ""
    field :cluster_password, :string, default: ""
    field :cluster_intention, :string, default: "cooperative"
    field :game_mode, :string, default: "survival"
    field :max_players, :integer, default: 6
    field :vote_enabled, :boolean, default: true
    field :pvp, :boolean, default: false
    field :steam_group_id, :string, default: ""
    field :steam_group_only, :boolean, default: false
    field :steam_group_admins, :boolean, default: true
    field :cluster_token, :string, default: ""
    field :cluster_key, :string
  end

  def shards(%__MODULE__{master_shard: master_shard, dependent_shards: dependent_shards}) do
    [master_shard | dependent_shards]
  end

  def new(params \\ %{}) do
    params =
      default_shards()
      |> Map.merge(params)
      |> apply_shard_ids()

    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:create)
  end

  def new!(params \\ %{}) do
    {:ok, cluster} = new(params)
    cluster
  end

  def update(%__MODULE__{} = cluster, params) do
    cluster
    |> changeset(params)
    |> apply_action(:update)
  end

  def changeset(%__MODULE__{} = cluster, params) do
    cluster
    |> cast(params, [
      :id,
      :cluster_name,
      :cluster_description,
      :cluster_password,
      :cluster_intention,
      :game_mode,
      :max_players,
      :vote_enabled,
      :pvp,
      :steam_group_id,
      :steam_group_only,
      :steam_group_admins,
      :cluster_token,
      :cluster_key
    ])
    |> ChangesetUtils.ensure_uuid_for_key(:id)
    |> ChangesetUtils.ensure_uuid_for_key(:cluster_key)
    |> cast_shard_embed(:master_shard, true, required: true)
    |> cast_shard_embed(:dependent_shards, false)
    |> cast_embed(:connections)
    |> validate_inclusion(:cluster_intention, ["coopreative", "competitive", "social", "madness"])
    |> validate_inclusion(:game_mode, ["survival", "wilderness", "endless"])
    |> validate_number(:max_players, greater_than_or_equal_to: 1, less_than_or_equal_to: 64)
  end

  defp cast_shard_embed(changeset, key, is_master, options \\ []) do
    cluster_id = ChangesetUtils.find_value(changeset, :id)
    shard_mod_changeset = {Shard, :cluster_nested_changeset, [%{"is_master" => is_master, "cluster_id" => cluster_id}]}

    cast_embed(changeset, key, [{:with, shard_mod_changeset} | options])
  end

  defp apply_shard_ids(%{"master_shard" => master_shard, "dependent_shards" => dependent_shards} = params) do
    params
    |> Map.put("master_shard", Map.put(master_shard, "id", "1"))
    |> Map.put(
      "dependent_shards",
      dependent_shards |> Enum.with_index(2) |> Enum.map(fn {shard, id} -> Map.put(shard, "id", Integer.to_string(id)) end)
    )
  end

  defp default_shards() do
    %{
      "master_shard" => %{"name" => "Forest", "location" => "forest"},
      "dependent_shards" => [%{"name" => "Caves", "location" => "cave"}]
    }
  end
end
