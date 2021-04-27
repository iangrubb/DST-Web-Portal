defmodule PortalDeployment.GameFileSystem.ModSetupLua do
  # alias PortalDeployment.GameFileSystem.ModsFolder

  # This should actually go in game_logic, not game_file. Refactor accordingly at some point.

  def path(id), do: "../game_logic/mods/dedicated_server_mods_setup.lua"

  def write_default(id), do: id |> path() |> File.write("ServerModSetup(\"595764362\")")
end
