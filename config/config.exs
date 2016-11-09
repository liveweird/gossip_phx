# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gossip_phx,
  ecto_repos: [GossipPhx.Repo]

# Configures the endpoint
config :gossip_phx, GossipPhx.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QY9+2PlFbyRmF7eO7sQw1W3VYBy+qlylTIDYdjpopf9Sk0UAeRJsSP5WhobNXD2H",
  render_errors: [view: GossipPhx.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GossipPhx.PubSub,
           adapter: Phoenix.PubSub.PG2],
  instance: "#{Mix.env}"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
