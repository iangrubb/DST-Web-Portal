defmodule PortalDeployment.Runtime.ServerProcess do
  use GenServer

  alias PortalDeployment.Runtime.Server

  # API

  def start_link([registered_server_name: registered_server_name] = _init_args) do

    # refactor how you hadle registered_names

    {_, _, {_, _, server}} = registered_server_name
    GenServer.start_link(__MODULE__, server, name: registered_server_name)
  end

  def send_to_stdin(pid, message) do
    GenServer.cast(pid, {:send_to_stdin, message})
  end

  # Callbacks

  def init(%Server{cluster_id: cluster_id, shard_id: shard_id} = server) do
    Process.flag(:trap_exit, true)

    {:ok, _pid, os_pid} =
      :exec.run_link(
        "./lib/portal_deployment/runtime/start_shard.sh #{cluster_id} #{shard_id}",
        [
          {:kill, "c_shutdown()"},
          {:kill_timeout, 10},
          :stdout,
          :stdin
        ]
      )

    {:ok, %{server: server, os_pid: os_pid}}
  end

  @impl true
  def handle_info(message, state) do
    IO.inspect message
    {:noreply, state}
  end

  @impl true
  def terminate(_, %{os_pid: os_pid}) do
    :exec.send(os_pid, "c_shutdown()\n")
  end
end
