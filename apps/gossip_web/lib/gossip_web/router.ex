defmodule GossipWeb.Router do
  use GossipWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GossipWeb do
    pipe_through :api
  end
end
