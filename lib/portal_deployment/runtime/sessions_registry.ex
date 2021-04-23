defmodule PortalDeployment.Runtime.SessionsRegistry do
  import Kernel, except: [send: 2]
  use GenServer
  alias PortalDeployment.Runtime.Session

  # Un-hardcode later with an env variable
  @max_shards 4

  # API

  def start_link(_initial_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def register_name(session, pid) when is_pid(pid) do
    GenServer.call(__MODULE__, {:register_name, session, pid})
  end

  def unregister_name(session) do
    GenServer.call(__MODULE__, {:unregister_name, session})
  end

  def whereis_name(session) do
    GenServer.call(__MODULE__, {:whereis_name, session})
  end

  def list_sessions() do
    GenServer.call(__MODULE__, :list_sessions)
  end

  def get_session(cluster_id) do
    GenServer.call(__MODULE__, {:get_session, cluster_id})
  end

  def send(session, msg) do
    case whereis_name(session) do
      pid when is_pid(pid) ->
        Kernel.send(pid, msg)
        pid

      :undefined ->
        {:badarg, {session, msg}}
    end
  end

  # Callbacks

  def init(nil) do
    {:ok, %{}}
  end

  def handle_call(
        {:register_name, %Session{cluster_id: key, shard_count: incoming_shards} = session, pid},
        _from,
        registry
      ) do
    session_count = registry |> Map.keys() |> Enum.count()

    proposed_session_number =
      0..session_count
      |> Enum.find(fn id ->
        registry |> Enum.all?(fn {_, {_, _, _, session_number}} -> id != session_number end)
      end)

    proposed_server_ids =
      registry
      |> available_server_slots()
      |> Enum.take(incoming_shards)

    case {Map.get(registry, key, nil), Enum.count(proposed_server_ids) == incoming_shards} do
      {nil, true} ->
        Process.monitor(pid)
        registry = Map.put(registry, key, {pid, session, proposed_server_ids, proposed_session_number})
        {:reply, :yes, registry}

      _ ->
        {:reply, :no, registry}
    end
  end

  def handle_call({:unregister_name, %Session{cluster_id: key} = session}, _from, registry) do
    {:reply, session, Map.delete(registry, key)}
  end

  def handle_call({:whereis_name, %Session{cluster_id: key}}, _from, registry) do
    reply =
      case Map.get(registry, key) do
        nil -> :undefined
        {pid, _session, _server_ids, _session_number} -> pid
      end

    {:reply, reply, registry}
  end

  def handle_call(:list_sessions, _from, registry) do
    {:reply, Map.values(registry), registry}
  end

  def handle_call({:get_session, cluster_id}, _from, registry) do
    reply =
      registry
      |> Enum.find(fn {key, _data} -> cluster_id == key end)
      |> case do
        nil -> {:error, "no session found"}
        {_key, data} -> {:ok, data}
      end

    {:reply, reply, registry}
  end

  def handle_info({:DOWN, _ref, :process, pid, _reason}, registry) do
    {:noreply, deregister_process(registry, pid)}
  end

  def handle_info(_info, registry), do: {:noreply, registry}

  defp deregister_process(registry, pid) when is_pid(pid) do
    case Enum.find(registry, nil, fn {_key, {cur_pid, _session, _server_ids, _session_number}} ->
           cur_pid == pid
         end) do
      nil -> registry
      {key, {_pid, _session, _server_ids, _session_number}} -> Map.delete(registry, key)
    end
  end

  defp available_server_slots(registry) do
    used_shards = server_slots_in_use(registry)

    0..(@max_shards - 1)
    |> Enum.reject(fn id ->
      Enum.any?(used_shards, fn used_id -> id == used_id end)
    end)
  end

  defp server_slots_in_use(registry) do
    registry
    |> Enum.map(fn {_cluster_id, {_pid, _session, server_slot_ids, session_number}} -> server_slot_ids end)
    |> Enum.concat()
  end
end
