defmodule PortalDeployment.Configuration.Cluster do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortalDeployment.Configuration.Shard

  embedded_schema do
    embeds_one :master_shard, Shard
    embeds_many :dependent_shards, Shard

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
    params = default_shards() |> Map.merge(params)

    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:create)
  end

  def update(%__MODULE__{} = cluster, params) do
    cluster
    |> changeset(params)
    |> apply_action(:update)
  end

  def changeset(%__MODULE__{} = cluster, params) do
    cluster
    |> cast(params, [
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
      :cluster_token
    ])
    |> cast_embed(:master_shard, required: true)
    |> cast_embed(:dependent_shards)
    |> validate_inclusion(:cluster_intention, ["coopreative", "competitive", "social", "madness"])
    |> validate_inclusion(:game_mode, ["survival", "wilderness", "endless"])
    |> validate_number(:max_players, greater_than_or_equal_to: 1, less_than_or_equal_to: 64)
    |> ensure_random_value_for_key(:id)
    |> ensure_random_value_for_key(:cluster_key)
  end

  defp ensure_random_value_for_key(changeset, key) do
    case Map.get(changeset.data, key) do
      nil -> changeset |> change(Map.put(%{}, key, Ecto.UUID.generate()))
      _ -> changeset
    end
  end

  defp default_shards() do
    %{
      "master_shard" => %{"name" => "Forest", "location" => "forest"},
      "dependent_shards" => [%{"name" => "Caves", "location" => "cave"}]
    }
  end
end
