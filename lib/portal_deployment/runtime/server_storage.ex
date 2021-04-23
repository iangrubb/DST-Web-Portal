defmodule PortalDeployment.Runtime.ServerStorage do
  alias PortalDeployment.Runtime.Server
  alias PortalDeployment.GameFiles.ServerIni
  
  # For server.ini
  @starting_server_port 10998
  @starting_master_server_port 27016
  @starting_authentication_port 8766

  def save(%Server{shard_id: shard_id, port_slot: port_slot, is_master: is_master}, cluster_id) do
    shard_path(cluster_id, shard_id)
    |> ServerIni.create_or_update(%{
      server_port: @starting_server_port + port_slot,
      master_server_port: @starting_master_server_port + port_slot,
      authentication_port: @starting_authentication_port + port_slot
    })
  end

  # I'd like to refactor the following in some way.
  # The game_files modules should probably own facts about file paths. Maybe file folder modules are needed?

  def shard_path(cluster_id, shard_id), do: "../game_files/clusters/" <> cluster_id <> "/" <> shard_id
end
