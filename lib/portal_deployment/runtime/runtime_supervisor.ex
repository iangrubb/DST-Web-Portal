defmodule PortalDeployment.Runtime.RuntimeSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      PortalDeployment.Runtime.SessionsSupervisor,
      {Registry, keys: :unique, name: SessionsRegistry},
      {Registry, keys: :unique, name: ServersRegistry}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
