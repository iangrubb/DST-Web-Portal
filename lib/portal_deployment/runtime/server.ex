defmodule PortalDeployment.Runtime.Server do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :shard_id, :string
  end

  def changeset(server, params) do

  end


end
