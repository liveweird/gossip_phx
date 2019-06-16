defmodule Chat.ChannelUser do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "channel_users" do
    field :user_id, :binary_id
    belongs_to :channel, Chat.Channel
    timestamps()
  end

  def changeset(channel_user, params \\ %{}) do
    channel_user
    |> Ecto.Changeset.cast(params, [:user_id])
    |> Ecto.Changeset.put_assoc(:channel, params.channel)
    |> Ecto.Changeset.validate_required([:user_id, :channel])
  end

end
