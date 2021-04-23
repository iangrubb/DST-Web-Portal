defmodule PortalDeployment.Runtime.SessionSupervisor do
  use DynamicSupervisor

  alias PortalDeployment.Runtime.ServerProcess

  def start_link([registered_session_name: registered_session_name] = init_args) do
    DynamicSupervisor.start_link(__MODULE__, init_args, name: registered_session_name)
  end

  def start_child(registered_session_name, registered_server_name) do
    DynamicSupervisor.start_child(
      registered_session_name,
      {ServerProcess, registered_server_name: registered_server_name}
    )
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
