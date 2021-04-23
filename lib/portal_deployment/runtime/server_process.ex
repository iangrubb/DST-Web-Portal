defmodule PortalDeployment.Runtime.ServerProcess do
  use GenServer
  # API

  def start_link([registered_server_name: registered_server_name] = _init_args) do
    GenServer.start_link(__MODULE__, nil, name: registered_server_name)
  end

  # Callbacks

  def init(nil) do
    IO.puts("ON")

    {:ok, nil}
  end
end
