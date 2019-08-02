defmodule Gossip.Repo.Migrations.CreateActiveUserTable do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIEW chat.active_users AS
    SELECT id, name, description
    FROM people.users
    WHERE is_active = true AND is_deleted = false
    ;
    """

  end

  def down do
    execute "DROP VIEW chat.active_users;"
  end
end
