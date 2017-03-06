defmodule GossipPhx.Web.PageController do
  use GossipPhx.Web, :controller

  @swagger_data (
    :gossip_phx
    |> Application.app_dir("priv/static/swagger.json")
    |> File.read!
    |> Poison.decode!
  )

  @spec index(%{}, %{}) :: any()
  def index(conn, _params) do
    render conn, data: @swagger_data
  end
end
