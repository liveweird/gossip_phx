use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gossip_phx, GossipPhx.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gossip_phx, GossipPhx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gossip_phx_test",
  hostname: "192.168.99.100",
  pool: Ecto.Adapters.SQL.Sandbox
