defmodule PortalDeployment.GameFiles.ServerIni do
  alias PortalDeployment.GameFiles.Helpers

  
  # Read data function

  def create_or_update(path, data) do
    new_content =
      path
      |> server_ini_path()
      |> Helpers.read_with_backup(template())
      |> Helpers.update_ini_file_contents(data)

    path
    |> server_ini_path()
    |> File.write!(new_content)
  end

  defp server_ini_path(path), do: path <> "/server.ini"

  defp template() do
    """
    [NETWORK]
    server_port = 

    [SHARD]
    is_master = 
    name = 
    id = 

    [ACCOUNT]
    encode_user_path = true

    [STEAM]
    master_server_port = 
    authentication_port = 
    """
  end
end
