use Mix.Config

# Configure your database
config :gossip, Gossip.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gossip_dev",
  hostname: "localhost",
  pool_size: 10
