defmodule PortalDeployment.GameFileSystem.ModSetupLua do
  alias PortalDeployment.GameFileSystem.ModsFolder

  def path(id), do: ModsFolder.path(id) <> "/dedicated_server_mods_setup.lua"

  def write_default(id), do: id |> path() |> File.write("ServerModSetup(\"595764362\")")
end
