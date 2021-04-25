defmodule PortalDeployment.Runtime.SessionStorage do
  alias PortalDeployment.GameFileSystem.ClusterIni

  @starting_master_port 10888

  def save_master_port(cluster_id, session_number) do
    ClusterIni.create_or_update(cluster_id, %{master_port: @starting_master_port + session_number})
  end
end
