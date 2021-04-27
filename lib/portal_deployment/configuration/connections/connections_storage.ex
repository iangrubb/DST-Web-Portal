defmodule PortalDeployment.Configuration.ConnectionsStorage do
  alias PortalDeployment.Configuration.Connections
  alias PortalDeployment.GameFileSystem.ModOverridesLua

  def save(cluster_id, shards, connections) do
    connection_data = if connections == nil, do: %{}, else: %{ "595764362" => connection_text(connections) }
    
    shards
    |> Enum.map(fn shard -> shard.id end)
    |> Enum.each(fn shard_id -> ModOverridesLua.write(cluster_id, shard_id, connection_data) end)
  end

  def connection_text(%Connections{two_way: two_way, one_way: one_way} = connections) do
    """
          ["Connections"] = {
    #{conns_from_grouping(two_way)}
          },
          ["OneWayConnections"] = {
    #{conns_from_grouping(one_way)}
          }
    """
    |> String.trim("\n")
  end

  defp conns_from_grouping(connection_list) do
    connection_list
    |> Enum.group_by(fn %{between: [from, _to]} -> from end)
    |> Enum.map(&conns_from_line/1)
    |> Enum.join(",\n")
  end

  defp conns_from_line({from, connections_to}) do
    destination_string =
      connections_to
      |> Enum.flat_map(fn %{between: [_from, to], count: count} ->
        1..(count)
        |> Enum.map(fn _ -> "\"#{to}\"" end)
      end)
      |> Enum.join(", ")

    """
            ["#{from}"] = { #{destination_string} }
    """
    |> String.trim("\n")
  end
end
