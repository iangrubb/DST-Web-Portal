defmodule PortalDeploymentWeb.ClusterView do
  use PortalDeploymentWeb, :view
  alias PortalDeploymentWeb.ClusterView

  def render("index.json", %{clusters: clusters}) do
    %{data: render_many(clusters, ClusterView, "cluster.json")}
  end

  def render("show.json", %{cluster: cluster}) do
    %{data: render_one(cluster, ClusterView, "cluster.json")}
  end

  def render("cluster.json", %{cluster: cluster}) do
    %{}
  end
end
