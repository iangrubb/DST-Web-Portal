defmodule PortalDeployment.Configuration.ShardCollection do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortalDeployment.Configuration.Shard

  @primary_key false
  embedded_schema do
    field :cluster_id, :string
    embeds_one :master_shard, Shard
    embeds_many :dependent_shards, Shard
  end

  def new(params) do
    params = default_shards() |> Map.merge(params)

    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:create)
  end

  def shards(%__MODULE__{master_shard: master_shard, dependent_shards: dependent_shards}) do
    [ master_shard | dependent_shards ]
  end

  def changeset(shard_collection, params) do
    shard_collection
    |> cast(params, [:cluster_id])
    |> cast_embed(:master_shard, required: true)
    |> cast_embed(:dependent_shards)
    |> validate_required(:cluster_id)
  end

  defp default_shards() do
    %{
      "master_shard" => %{"name" => "Forest", "location" => "forest"},
      "dependent_shards" => [%{"name" => "Caves", "location" => "cave"}]
    }
  end
end
