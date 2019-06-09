defmodule Chat.Service do

  import Ecto.Query

  def get_all_channels do
    query =
      from c in Chat.Channel,
      where: c.is_deleted == :false

    query
    |> Gossip.Repo.all
  end

  def create_channel(channel_name) when is_nil(channel_name) do
    {:error, "Can't create channel without name."}
  end

  def create_channel(channel_name) do
    changeset = Chat.Channel.changeset(%Chat.Channel{}, %{name: channel_name, is_private: false, is_deleted: false})

    with {:error, _} <- get_channel(channel_name),
         {:ok, %Chat.Channel{} = inserted} <- Gossip.Repo.insert(changeset)
    do
      {:ok, inserted}
    else
      _ -> {:error, "Channel has not been created."}
    end
  end

  def get_channel(channel_name) do
    query =
      from c in Chat.Channel,
      where: c.name == ^channel_name,
      where: c.is_deleted == :false

    result =
      case query |> Gossip.Repo.one do
        %Chat.Channel{} = retrieved -> {:ok, retrieved}
        nil -> {:error, "Channel has not been found."}
      end

    result
  end

  def join_channel(channel_name, user_name) do
    with {:ok, channel} <- get_channel(channel_name),
         {:ok, user} <- People.Contract.get_user(user_name)
    do
      changeset = Chat.ChannelUser.changeset(%Chat.ChannelUser{}, %{channel: channel, user_id: user.id})

      result =
        case Gossip.Repo.insert(changeset) do
          {:ok, %Chat.ChannelUser{} = inserted} -> {:ok, inserted}
          _ -> {:error, "User did not joined the channel."}
        end

      result
    else
      {:error, _} -> {:error, "User cannot join this particular channel."}
    end
  end

end
