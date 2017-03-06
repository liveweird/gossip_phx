defmodule GossipPhx do
  @moduledoc """
  Key application module for Gossip API
  """

  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @spec start(any(), any()) :: pid()
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(GossipPhx.Repo, []),
      # Start the endpoint when the application starts
      supervisor(GossipPhx.Web.Endpoint, []),
      # Start the Redis client
      worker(GossipPhx.RedisApi, [])
      # Start your own worker: GossipPhx.Worker.start_link(arg1, arg2, arg3)
      # worker(GossipPhx.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GossipPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
