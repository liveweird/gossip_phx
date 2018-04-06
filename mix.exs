defmodule GossipPhx.Mixfile do
  use Mix.Project

  def project do
    [app: :gossip_phx,
     version: "0.0.1",
     elixir: "~> 1.6.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {GossipPhx, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :phoenix_live_reload, :redix
                   ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.2"},
     {:phoenix_pubsub, "~> 1.0.2"},
     {:phoenix_ecto, "~> 3.3.0"},
     {:postgrex, "~> 0.13.5"},
     {:phoenix_html, "~> 2.11.1"},
     {:phoenix_live_reload, "~> 1.1.3"},
     {:gettext, "~> 0.15.0"},
     {:cowboy, "~> 1.1.2"},
     {:redix, "~> 0.7.0"},
     {:phoenix_swagger, "~> 0.8.0"},
     {:ex_json_schema, "~> 0.5.6"},
     {:cors_plug, "~> 1.5.2"},
     {:credo, "~> 0.9.0", only: [:dev, :test]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end

