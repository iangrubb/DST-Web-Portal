defmodule PortalDeployment.Runtime.SessionStorage do
  alias PortalDeployment.GameFiles.ClusterIni

  # For cluster.ini
  @starting_master_port 10888

  def save_master_port(cluster_id, session_number) do
    cluster_path(cluster_id)
    |> ClusterIni.create_or_update(%{master_port: @starting_master_port + session_number})
  end

  # I'd like to refactor the following in some way.
  # The game_files modules should probably own facts about file paths. Maybe file folder modules are needed?

  def cluster_path(cluster_id), do: "../game_files/clusters/" <> cluster_id
end
