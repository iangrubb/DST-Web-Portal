defmodule PortalDeployment.Configuration.WorldGeneration do
  use Ecto.Type

  alias PortalDeployment.Configuration.ForestGeneration
  alias PortalDeployment.Configuration.CaveGeneration

  def type, do: :map

  def cast(%{"location" => "forest"} = data), do: %ForestGeneration{} |> ForestGeneration.changeset(data) |> Ecto.Changeset.apply_action(:create)

  def cast(%{"location" => "cave"} = data), do: %CaveGeneration{} |> CaveGeneration.changeset(data) |> Ecto.Changeset.apply_action(:create)

  def cast(%ForestGeneration{} = gen), do: {:ok, gen}

  def cast(%CaveGeneration{} = gen), do: {:ok, gen}

  def cast(_), do: :error

  def load(_), do: IO.puts "Unexpected Call"

  def dump(_), do: IO.puts "Unexpected Call"
end
