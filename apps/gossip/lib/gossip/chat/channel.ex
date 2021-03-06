defmodule Chat.Channel do
  @moduledoc """
  Representation of a channel.
  """
  use Ecto.Schema

  @schema_prefix "chat"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "channels" do
    field :name, :string
    field :is_private, :boolean, default: false
    field :is_deleted, :boolean, default: false
    has_many :channel_users, Chat.ChannelUser
    timestamps()
  end

  def changeset(channel, params \\ %{}) do
    channel
    |> Ecto.Changeset.cast(params, [:name, :is_private, :is_deleted])
    |> Ecto.Changeset.validate_required([:name, :is_private, :is_deleted])
  end

end
