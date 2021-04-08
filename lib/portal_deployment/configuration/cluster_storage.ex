defmodule PortalDeployment.Configuration.ClusterStorage do
  alias PortalDeployment.Configuration.Cluster
  alias Ecto.Changeset

  @clusters_path "../game_files/clusters/"

  def all() do
    {:ok, cluster_ids} = File.ls(@clusters_path)

    cluster_ids |> Enum.map(&find!/1)
  end

  def find!(id) do
    {:ok, base_cluster} =
      %Cluster{}
      |> Changeset.change(%{id: id})
      |> Changeset.apply_action(:create)

    base_cluster
    |> Cluster.changeset(read_cluster_data(id))
    |> Changeset.apply_action(:create)
    |> case do
      {:ok, cluster} -> cluster
    end
  end

  def create(%Changeset{data: %Cluster{}} = changeset), do: mutate(changeset, :insert)

  def update(%Changeset{data: %Cluster{}} = changeset), do: mutate(changeset, :update)

  defp mutate(%Changeset{data: %Cluster{}} = changeset, action) do
    case Changeset.apply_action(changeset, action) do
      {:ok, cluster} ->
        save(cluster)
        {:ok, cluster}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp save(%Cluster{} = cluster) do
    ensure_directory(cluster)
    put_cluster_ini(cluster)
    put_cluster_token(cluster)
  end

  defp cluster_path(id), do: @clusters_path <> id

  defp cluster_ini_path(id), do: cluster_path(id) <> "/cluster.ini"

  defp cluster_token_path(id), do: cluster_path(id) <> "/cluster_token.txt"

  defp ensure_directory(%Cluster{id: id} = cluster) do
    id |> cluster_path() |> File.mkdir_p()
  end

  defp put_cluster_token(%Cluster{id: id, cluster_token: cluster_token} = cluster) do
    id |> cluster_token_path() |> File.write!(cluster_token)
  end

  defp put_cluster_ini(%Cluster{id: id} = cluster) do
    id |> cluster_ini_path() |> File.write!(cluster_ini_template(cluster))
  end

  defp cluster_ini_template(%Cluster{} = cluster) do
    """
    [GAMEPLAY]

    game_mode = #{cluster.game_mode}
    max_players = #{cluster.max_players}
    pvp = #{cluster.pvp}
    pause_when_empty = true
    vote_enabled = #{cluster.vote_enabled}

    [NETWORK]

    cluster_name = #{cluster.cluster_name}
    cluster_description = #{cluster.cluster_description}
    cluster_intention = #{cluster.cluster_intention}
    cluster_password = #{cluster.cluster_password}
    tick_rate = 15

    [MISC]

    console_enabled = true

    [STEAM]

    steam_group_id = #{cluster.steam_group_id}
    steam_group_only = #{cluster.steam_group_only}
    steam_group_admins = #{cluster.steam_group_admins}

    [SHARD]

    shard_enabled = true
    bind_ip = 127.0.0.1
    master_ip = 127.0.0.1
    master_port = 11000
    cluster_key = [randomize_me]
    """
  end

  def read_cluster_data(id) do
    with {:ok, cluster_token} <- File.read(cluster_token_path(id)),
         {:ok, cluster_ini_text} <- File.read(cluster_ini_path(id)) do
      cluster_ini_text
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, "=") end)
      |> Enum.filter(fn line -> Enum.count(line) == 2 end)
      |> Enum.reduce(%{}, fn [key, value], hash ->
        Map.put(hash, String.trim(key), String.trim(value))
      end)
      |> Map.put("cluster_token", cluster_token)
    end
  end
end
