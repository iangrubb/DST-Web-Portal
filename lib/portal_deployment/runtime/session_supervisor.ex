defmodule PortalDeployment.Runtime.SessionSupervisor do
  use DynamicSupervisor

  def start_link([registered_session_name: registered_session_name] = init_args) do
    DynamicSupervisor.start_link(__MODULE__, init_args, name: registered_session_name)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end


  # @impl true
  # def init(cluster_name: cluster_name) do
  #   # This can eventually look up config info to start children more dynamically. For now, hardcode a master and a cave server

  #   children = [
  #     active_shard_child_spec(cluster_name, "Master"),
  #     active_shard_child_spec(cluster_name, "Caves")
  #   ]

  #   Supervisor.init(children, strategy: :one_for_one)
  # end

  # def active_shard_child_spec(cluster_name, shard_name) do
  #   %{
  #     id: shard_name,
  #     start: {ActiveShard, :start_link, [[cluster_name: cluster_name, shard_name: shard_name]]}
  #   }
  # end

end
