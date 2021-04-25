defmodule PortalDeployment.Utils.Changeset do

  def find_value(changeset, key) do
    case {Map.get(changeset.data, key), Map.get(changeset.changes, key)} do
      {value, nil} -> value
      {nil, value} -> value
      {nil, nil} -> nil
    end
  end

  def ensure_uuid_for_key(changeset, key) do
    case find_value(changeset, key) do
      nil -> changeset |> Ecto.Changeset.change(Map.put(%{}, key, Ecto.UUID.generate()))
      _value -> changeset
    end
  end
end