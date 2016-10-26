defmodule GossipPhx.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text

      timestamps()
    end

  end
end
