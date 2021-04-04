defmodule PortalDeploymentWeb.ClusterController do
  use PortalDeploymentWeb, :controller

  alias PortalDeployment.Configuration

  action_fallback PortalDeploymentWeb.FallbackController

  def index(conn, _params) do
    # clusters = Configuration.list_clusters()
    # render(conn, "index.json", clusters: clusters)
  end

  def create(conn, %{"cluster" => cluster_params}) do
    # with {:ok, %Cluster{} = cluster} <- Configuration.create_cluster(cluster_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.cluster_path(conn, :show, cluster))
    #   |> render("show.json", cluster: cluster)
    # end
  end

  def show(conn, %{"name" => name}) do
    # cluster = Configuration.get_cluster!(id)
    # render(conn, "show.json", cluster: cluster)
  end

  def delete(conn, %{"name" => name}) do
    # cluster = Configuration.get_cluster!(id)

    # with {:ok, %Cluster{}} <- Configuration.delete_cluster(cluster) do
    #   send_resp(conn, :no_content, "")
    # end
  end
end
