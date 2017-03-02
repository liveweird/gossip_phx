defmodule GossipPhx.PageController do
  use GossipPhx.Web, :controller

  @swagger_data (
    Application.app_dir(:gossip_phx, "priv/static/swagger.json")
    |> File.read!
    |> Poison.decode!
  )

  def index(conn, _params) do
    render conn, data: @swagger_data
  end
end
