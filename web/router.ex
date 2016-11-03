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
  end

  scope "/", GossipPhx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/messages", MessageController
    get "/whispers", WhisperController, :index
    post "/whispers/new", WhisperController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GossipPhx do
  #   pipe_through :api
  # end
end
