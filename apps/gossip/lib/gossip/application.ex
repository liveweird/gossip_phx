defmodule Gossip.Application do
  @moduledoc """
  The Gossip Application Service.

  The gossip system business domain lives in this application.

  Exposes API to clients such as the `GossipWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Gossip.Repo, []),
    ], strategy: :one_for_one, name: Gossip.Supervisor)
  end
end
