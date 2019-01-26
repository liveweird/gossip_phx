defmodule Gossip.Repo.Migrations.CreateChannelTables do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :id, :binary_id, primary_key: true, autogenerate:
      add :name, :string
      add :is_private, :boolean, default: false
      timestamps()
      end

    create table(:channel_users, primary_key: false) do
      add :id, :binary_id, primary_key: true, autogenerate:
      add :user_id, :binary_id
      add :channel_id, references("channels", type: :binary_id)
      timestamps()
      end
  end
end
