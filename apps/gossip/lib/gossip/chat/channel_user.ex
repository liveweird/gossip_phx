defmodule Chat.ChannelUser do
  use Ecto.Schema

  schema "channel_user" do
    @primary_key {:id, :binary_id, autogenerate: true}
    field :user_id, :binary_id
    belongs_to :channel, Chat.Channel
    timestamps()
  end
end
