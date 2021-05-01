defmodule PortalDeployment.Configuration.WorldGen do
  use Ecto.Type

  alias PortalDeployment.Configuration.ForestGen
  alias PortalDeployment.Configuration.CaveGen

  def type, do: :map

  def cast(%{"location" => "forest"} = data),
    do: %ForestGen{} |> ForestGen.changeset(data) |> Ecto.Changeset.apply_action(:create)

  def cast(%{"location" => "cave"} = data),
    do: %CaveGen{} |> CaveGen.changeset(data) |> Ecto.Changeset.apply_action(:create)

  def cast(%ForestGen{} = gen), do: {:ok, gen}

  def cast(%CaveGen{} = gen), do: {:ok, gen}

  def cast(_), do: :error

  def load(_), do: IO.puts("Unexpected Call")

  def dump(_), do: IO.puts("Unexpected Call")
end
