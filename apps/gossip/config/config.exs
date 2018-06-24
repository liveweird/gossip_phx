use Mix.Config

config :gossip, ecto_repos: [Gossip.Repo]

import_config "#{Mix.env}.exs"
