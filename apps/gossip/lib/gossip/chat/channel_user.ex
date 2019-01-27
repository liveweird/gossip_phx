defmodule Chat.ChannelUser do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "channel_users" do
    field :user_id, :binary_id
    belongs_to :channel, Chat.Channel
    timestamps()
  end
end
