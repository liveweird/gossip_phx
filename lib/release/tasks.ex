defmodule Release.Tasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:my_app)
    path = Application.app_dir(:my_app, "priv/repo/migrations")
    Ecto.Migrator.run(MyApp.Repo, path, :up, all: true)
    :init.stop()
  end
end
