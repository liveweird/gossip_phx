defmodule Gossip.Repo.Migrations.CreateChannelTables do
  use Ecto.Migration

  def change do
    execute "CREATE SCHEMA chat"

    create table(:channels, prefix: "chat", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :is_private, :boolean, default: false
      add :is_deleted, :boolean, default: false
      timestamps()
      end

    create table(:channel_users, prefix: "chat", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :uuid
      add :channel_id, references("channels", prefix: "chat", column: :id, type: :uuid)
      timestamps()
      end
  end
end
