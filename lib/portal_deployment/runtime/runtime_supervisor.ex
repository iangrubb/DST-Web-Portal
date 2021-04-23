defmodule PortalDeployment.Runtime.RuntimeSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      PortalDeployment.Runtime.SessionsRegistry,
      {Registry, keys: :unique, name: ServersRegistry},
      PortalDeployment.Runtime.SessionsSupervisor
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
