defmodule PortalDeployment.GameFiles.ClusterToken do
  def read(base_path) do
    base_path
    |> cluster_token_path()
    |> File.read()
  end

  def write(base_path, token) do
    base_path
    |> cluster_token_path()
    |> File.write!(token)
  end

  defp cluster_token_path(base_path), do: base_path <> "/cluster_token.txt"
end
