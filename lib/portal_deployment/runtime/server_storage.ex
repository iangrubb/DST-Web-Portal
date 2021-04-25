defmodule PortalDeployment.Runtime.ServerStorage do
  alias PortalDeployment.Runtime.Server
  alias PortalDeployment.GameFileSystem.ServerIni

  @starting_server_port 10998
  @starting_master_server_port 27016
  @starting_authentication_port 8766

  def save(%Server{shard_id: shard_id, port_slot: port_slot}, cluster_id) do
    ServerIni.create_or_update(cluster_id, shard_id, %{
      server_port: @starting_server_port + port_slot,
      master_server_port: @starting_master_server_port + port_slot,
      authentication_port: @starting_authentication_port + port_slot
    })
  end
end
