defmodule GossipPhx.PageController do
  use GossipPhx.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
