defmodule PortalDeployment.Runtime do
  @moduledoc """
  The Runtime context.
  """

  alias PortalDeployment.Runtime.Server
  alias PortalDeployment.Runtime.ServerStorage
  alias PortalDeployment.Runtime.SessionServersSupervisor
  alias PortalDeployment.Runtime.Session
  alias PortalDeployment.Runtime.SessionStorage
  alias PortalDeployment.Runtime.SessionsRegistry
  alias PortalDeployment.Runtime.SessionsSupervisor
  alias PortalDeployment.Configuration
  alias PortalDeployment.Configuration.Cluster

  def list_sessions(), do: SessionsRegistry.list_sessions()

  def get_session(cluster_id), do: SessionsRegistry.get_session(cluster_id)

  def start_session(cluster_id) do
    case Configuration.get_cluster(cluster_id) do
      {:ok, cluster} -> create_session_for_cluster(cluster)
      error_tuple -> error_tuple
    end
  end

  # PortalDeployment.Runtime.start_session("987318cb-dcd3-4bb9-bb01-274f6b8d1956")

  def delete_session(cluster_id) do
    case get_session(cluster_id) do
      {:ok, {pid, session, _port_slot, _session_number}} ->
        SessionsSupervisor.terminate_child(pid)

      error_tuple ->
        error_tuple
    end
  end

  def restart_session(cluster_id) do
    delete_session(cluster_id)
    start_session(cluster_id)
  end

  defp create_session_for_cluster(cluster) do
    session =
      Session.new(%{
        cluster_id: cluster.id,
        shard_count: cluster |> Cluster.shards() |> Enum.count()
      })

    session
    |> registered_session_name()
    |> SessionsSupervisor.start_child()
    |> case do
      {:ok, pid} ->
        {:ok, {pid, _session, port_slots, session_number}} = get_session(cluster.id)

        SessionStorage.save_master_port(cluster.id, session_number)

        Cluster.shards(cluster)
        |> Enum.zip(port_slots)
        |> Enum.each(fn {shard, port_slot} ->
          {:ok, server} =
            Server.new(%{
              cluster_id: cluster.id,
              shard_id: shard.id,
              port_slot: port_slot,
              is_master: shard.is_master
            })

          ServerStorage.save(server, cluster.id)

          SessionServersSupervisor.start_child(
            registered_session_name(session),
            registered_server_name(server)
          )
        end)

        {:ok, session}

      {:error, _} ->
        {:error, "unable to start session"}
    end
  end

  defp registered_session_name(session) do
    {:via, SessionsRegistry, session}
  end

  defp registered_server_name(%Server{shard_id: shard_id} = server) do
    {:via, Registry, {ServersRegistry, shard_id, server}}
  end
end
