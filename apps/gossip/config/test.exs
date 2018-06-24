use Mix.Config

# Configure your database
config :gossip, Gossip.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gossip_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
