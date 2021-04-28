defmodule PortalDeployment.Configuration.ConnectionsStorage do
  alias PortalDeployment.Configuration.Connections
  alias PortalDeployment.GameFileSystem.ModOverridesLua

  def save(cluster_id, shards, connections) do
    connection_data = if connections == nil, do: %{}, else: %{ "595764362" => connection_text(connections) }
    
    shards
    |> Enum.map(fn shard -> shard.id end)
    |> Enum.each(fn shard_id -> ModOverridesLua.write(cluster_id, shard_id, connection_data) end)
  end

  def get_raw_data(cluster_id, master_shard_id) do
    ModOverridesLua.read!(cluster_id, master_shard_id)
    |> Map.get("595764362")
    |> case do
      nil -> nil
      content ->
        [two_way_lines, one_way_lines] = parse_content(content)

        %{}
        |> Map.put("one_way", Enum.flat_map(one_way_lines, &parse_line/1))
        |> Map.put("two_way", Enum.flat_map(two_way_lines, &parse_line/1))
    end
  end

  defp parse_content(content) do
    content
    |> String.trim_leading("      [\"Connections\"] = {\n")
    |> String.trim_trailing("      }")
    |> String.split("      },\n      [\"OneWayConnections\"] = {")
    |> Enum.map(fn string -> string |> String.trim("\n") |> String.split("\n") end)
  end

  defp parse_line(line) do
    [from_str, to_str] = String.split(line, "=")
    [_, from, _] = String.split(from_str, "\"")

    to_str
    |> String.split("\"")
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(fn [_, num] -> num end)
    |> Enum.frequencies()
    |> Enum.map(fn {to, count} -> %{"between" => [from, to], "count" => count} end)
  end

  defp connection_text(%Connections{two_way: two_way, one_way: one_way}) do
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
