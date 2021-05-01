defmodule PortalDeployment.Configuration.Connections do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortalDeployment.Configuration.Connection

  @primary_key false
  embedded_schema do
    embeds_many :two_way, Connection
    embeds_many :one_way, Connection
  end

  # Validate at most 10 links going out from a specific shard

  def changeset(connections, params) do
    connections
    |> cast(params, [])
    |> cast_embed(:two_way)
    |> cast_embed(:one_way)
    |> validate_non_duplication(:two_way, fn conn ->
      conn.changes.between |> Enum.sort() |> Enum.join()
    end)
    |> validate_non_duplication(:one_way, fn conn -> conn.changes.between |> Enum.join() end)
  end

  defp validate_non_duplication(changeset, key, conn_identity_function) do
    validate_change(changeset, key, fn key, connections ->
      connections
      |> Enum.reduce_while(%{}, fn conn, record ->
        key = conn_identity_function.(conn)

        case Map.get(record, key) do
          nil -> {:cont, Map.put(record, key, true)}
          true -> {:halt, nil}
        end
      end)
      |> case do
        nil -> [{key, "connections can't have duplicate pairs"}]
        _ -> []
      end
    end)
  end
end
