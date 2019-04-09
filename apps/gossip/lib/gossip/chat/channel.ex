defmodule Chat.Channel do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "channels" do
    field :name, :string
    field :is_private, :boolean, default: false
    field :is_deleted, :boolean, default: false
    has_many :channel_users, Chat.ChannelUser
    timestamps()
  end
end