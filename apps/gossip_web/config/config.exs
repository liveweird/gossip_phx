# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gossip_web,
  namespace: GossipWeb,
  ecto_repos: [Gossip.Repo]

# Configures the endpoint
config :gossip_web, GossipWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F9IK1rnR2S1XuIxoJxRkt8vbgfmq3ysd7EW8ZxfKhW01PIPlkZXngE8P2CkJOuum",
  render_errors: [view: GossipWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GossipWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :gossip_web, :generators,
  context_app: :gossip

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
