defmodule PortalDeployment.Runtime do
  @moduledoc """
  The Runtime context.
  """

  alias PortalDeployment.Runtime.Server
  alias PortalDeployment.Runtime.Session
  alias PortalDeployment.Runtime.SessionsSupervisor
  alias PortalDeployment.Configuration

  def list_sessions() do
    Registry.select(SessionsRegistry, [{{:_, :"$1", :"$2"}, [], [{{:"$1", :"$2"}}]}])
  end

  def get_session(cluster_id) do
    case Registry.lookup(SessionsRegistry, cluster_id) do
      [] -> nil
      [{pid, session_data}] -> {pid, session_data}
    end
  end

  def start_session(cluster_id) do
    case {get_session(cluster_id), Configuration.get_cluster(cluster_id)} do
      {_, nil} -> {:error, "no cluster found"}
      {nil, {:ok, cluster}} -> {:ok, create_session_for_cluster(cluster)}
      {_, _} -> {:error, "alrady running"}
    end
  end

  def delete_session(cluster_id) do

  end

  def restart_session(cluster_id) do
    # Might need a delay between these, depending on how delete works
    delete_session(cluster_id)
    start_session(cluster_id)
  end

  defp create_session_for_cluster(cluster) do



    cluster
    |> Session.new()
    |> registered_session_name()
    |> SessionsSupervisor.start_child()
  end

  defp registered_session_name(%Session{cluster_id: cluster_id} = session) do
    {:via, Registry, {SessionsRegistry, cluster_id, session}}
  end

  defp registered_server_name(%Server{shard_id: shard_id} = server) do
    {:via, Registry, {ServersRegistry, shard_id, server}}
  end
end
