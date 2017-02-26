defmodule GossipPhx.Router do
  use GossipPhx.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    # plug PhoenixSwagger.Plug.Validate
  end

  scope "/", GossipPhx do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/api", GossipPhx do
    pipe_through :api
    resources "/channels", ChannelController, except: [:new, :edit]
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Gossip"
      }
    }
  end
end
