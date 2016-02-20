ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GossipPhx.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GossipPhx.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GossipPhx.Repo)

