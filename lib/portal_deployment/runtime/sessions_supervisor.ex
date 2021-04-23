defmodule PortalDeployment.Runtime.SessionsSupervisor do
  use DynamicSupervisor

  alias PortalDeployment.Runtime.SessionSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_child(registered_session_name) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {SessionSupervisor, registered_session_name: registered_session_name}
    )
  end

  def terminate_child(registered_session_name) do
    DynamicSupervisor.terminate_child(__MODULE__, registered_session_name) 
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
