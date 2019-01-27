defmodule Gossip.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_name, :string
      add :description, :string
      add :is_active, :boolean, default: true
      add :is_deleted, :boolean, default: false
      timestamps()
    end
  end
end
