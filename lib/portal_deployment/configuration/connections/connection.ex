defmodule PortalDeployment.Configuration.Connection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :between, {:array, :string}
    field :count, :integer
  end

  def changeset(connection, params) do
    connection
    |> cast(params, [:between, :count])
    |> validate_change(:between, fn
      :between, [thing, thing] -> [between: "ids must be distinct"]
      :between, [first, second] -> []
      :between, _ -> [between: "must contain two elements"]
    end)
  end
end
