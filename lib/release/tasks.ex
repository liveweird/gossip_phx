defmodule Release.Tasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:gossip_phx)
    path = Application.app_dir(:gossip_phx, "priv/repo/migrations")
    Ecto.Migrator.run(MyApp.Repo, path, :up, all: true)
    :init.stop()
  end
end
