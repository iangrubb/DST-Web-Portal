defmodule PortalDeployment.Configuration.Cluster do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :cluster_name, :string, default: "MyNewCluster"
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
    field :cluster_key, :string, default: "some_random_value?"
  end

  def changeset(cluster, params) do
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
    |> validate_inclusion(:cluster_intention, ["coopreative", "competitive", "social", "madness"])
    |> validate_inclusion(:game_mode, ["survival", "wilderness", "endless"])
    |> validate_number(:max_players, greater_than_or_equal_to: 1, less_than_or_equal_to: 64)
    |> ensure_id()
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{id: nil}} = changeset) do
    changeset |> change(%{id: Ecto.UUID.generate()})
  end

  defp ensure_id(%Ecto.Changeset{data: %__MODULE__{}} = changeset), do: changeset
end
