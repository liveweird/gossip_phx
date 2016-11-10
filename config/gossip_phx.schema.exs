@moduledoc """
A schema is a keyword list which represents how to map, transform, and validate
configuration values parsed from the .conf file. The following is an explanation of
each key in the schema definition in order of appearance, and how to use them.

## Import

A list of application names (as atoms), which represent apps to load modules from
which you can then reference in your schema definition. This is how you import your
own custom Validator/Transform modules, or general utility modules for use in
validator/transform functions in the schema. For example, if you have an application
`:foo` which contains a custom Transform module, you would add it to your schema like so:

`[ import: [:foo], ..., transforms: ["myapp.some.setting": MyApp.SomeTransform]]`

## Extends

A list of application names (as atoms), which contain schemas that you want to extend
with this schema. By extending a schema, you effectively re-use definitions in the
extended schema. You may also override definitions from the extended schema by redefining them
in the extending schema. You use `:extends` like so:

`[ extends: [:foo], ... ]`

## Mappings

Mappings define how to interpret settings in the .conf when they are translated to
runtime configuration. They also define how the .conf will be generated, things like
documention, @see references, example values, etc.

See the moduledoc for `Conform.Schema.Mapping` for more details.

## Transforms

Transforms are custom functions which are executed to build the value which will be
stored at the path defined by the key. Transforms have access to the current config
state via the `Conform.Conf` module, and can use that to build complex configuration
from a combination of other config values.

See the moduledoc for `Conform.Schema.Transform` for more details and examples.

## Validators

Validators are simple functions which take two arguments, the value to be validated,
and arguments provided to the validator (used only by custom validators). A validator
checks the value, and returns `:ok` if it is valid, `{:warn, message}` if it is valid,
but should be brought to the users attention, or `{:error, message}` if it is invalid.

See the moduledoc for `Conform.Schema.Validator` for more details and examples.
"""
[
  extends: [],
  import: [],
  mappings: [
    "logger.console.format": [
      commented: false,
      datatype: :binary,
      default: """
      $time $metadata[$level] $message
      """,
      doc: "Provide documentation for logger.console.format here.",
      hidden: false,
      to: "logger.console.format"
    ],
    "logger.console.metadata": [
      commented: false,
      datatype: [
        list: :atom
      ],
      default: [
        :request_id
      ],
      doc: "Provide documentation for logger.console.metadata here.",
      hidden: false,
      to: "logger.console.metadata"
    ],
    "logger.level": [
      commented: false,
      datatype: :atom,
      default: :info,
      doc: "Provide documentation for logger.level here.",
      hidden: false,
      to: "logger.level"
    ],
    "phoenix.serve_endpoints": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for phoenix.serve_endpoints here.",
      hidden: false,
      to: "phoenix.serve_endpoints"
    ],
    "gossip_phx.ecto_repos": [
      commented: false,
      datatype: [
        list: :atom
      ],
      default: [
        GossipPhx.Repo
      ],
      doc: "Provide documentation for gossip_phx.ecto_repos here.",
      hidden: false,
      to: "gossip_phx.ecto_repos"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.url.host": [
      commented: false,
      datatype: :binary,
      default: "localhost",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.url.host here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.url.host"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.view": [
      commented: false,
      datatype: :atom,
      default: GossipPhx.ErrorView,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.view here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.view"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.accepts": [
      commented: false,
      datatype: [
        list: :binary
      ],
      default: [
        "html",
        "json"
      ],
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.accepts here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.render_errors.accepts"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.name": [
      commented: false,
      datatype: :atom,
      default: GossipPhx.PubSub,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.name here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.name"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.adapter": [
      commented: false,
      datatype: :atom,
      default: Phoenix.PubSub.PG2,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.adapter here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.pubsub.adapter"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.instance": [
      commented: false,
      datatype: :binary,
      default: "dunno",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.instance here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.instance"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.http.port": [
      commented: false,
      datatype: :integer,
      default: 4000,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.http.port here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.http.port"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.cache_static_manifest": [
      commented: false,
      datatype: :binary,
      default: "priv/static/manifest.json",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.cache_static_manifest here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.cache_static_manifest"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.server": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.server here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.server"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.root": [
      commented: false,
      datatype: :binary,
      default: ".",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.root here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.root"
    ],
    "gossip_phx.Elixir.GossipPhx.Endpoint.secret_key_base": [
      commented: false,
      datatype: :binary,
      default: "pigdM8RPvj2f8F4XVsxF6pMJGV2LY4BECEeO1819T0cmb+m2lwCrn1SXixK0y1gC",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Endpoint.secret_key_base here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Endpoint.secret_key_base"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.adapter": [
      commented: false,
      datatype: :atom,
      default: Ecto.Adapters.Postgres,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.adapter here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.adapter"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.hostname": [
      commented: false,
      datatype: :binary,
      default: "postgres",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.hostname here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.hostname"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.username": [
      commented: false,
      datatype: :binary,
      default: "postgres",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.username here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.username"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.password": [
      commented: false,
      datatype: :binary,
      default: "postgres",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.password here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.password"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.database": [
      commented: false,
      datatype: :binary,
      default: "gossip_phx_prod",
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.database here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.database"
    ],
    "gossip_phx.Elixir.GossipPhx.Repo.pool_size": [
      commented: false,
      datatype: :integer,
      default: 20,
      doc: "Provide documentation for gossip_phx.Elixir.GossipPhx.Repo.pool_size here.",
      hidden: false,
      to: "gossip_phx.Elixir.GossipPhx.Repo.pool_size"
    ],
    "exredis.host": [
      commented: false,
      datatype: :binary,
      default: "redis",
      doc: "Provide documentation for exredis.host here.",
      hidden: false,
      to: "exredis.host"
    ],
    "exredis.port": [
      commented: false,
      datatype: :integer,
      default: 6379,
      doc: "Provide documentation for exredis.port here.",
      hidden: false,
      to: "exredis.port"
    ],
    "exredis.password": [
      commented: false,
      datatype: :binary,
      doc: "Provide documentation for exredis.password here.",
      hidden: false,
      to: "exredis.password"
    ],
    "exredis.db": [
      commented: false,
      datatype: :integer,
      default: 0,
      doc: "Provide documentation for exredis.db here.",
      hidden: false,
      to: "exredis.db"
    ],
    "exredis.reconnect": [
      commented: false,
      datatype: :atom,
      default: :no_reconnect,
      doc: "Provide documentation for exredis.reconnect here.",
      hidden: false,
      to: "exredis.reconnect"
    ],
    "exredis.max_queue": [
      commented: false,
      datatype: :atom,
      default: :infinity,
      doc: "Provide documentation for exredis.max_queue here.",
      hidden: false,
      to: "exredis.max_queue"
    ]
  ],
  transforms: [],
  validators: []
]
