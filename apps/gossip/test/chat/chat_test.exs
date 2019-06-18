defmodule Chat.ChannelTest do
  use Gossip.DataCase

  describe "channels" do

    test "empty list of channels" do
      channels = Chat.Contract.get_all_channels()

      assert length(channels) == 0
    end

    test "create a channel" do
      {:ok, inserted} = Chat.Contract.create_channel("xyz")

      assert inserted.name == "xyz"
      assert inserted.is_private == false
      assert inserted.is_deleted == false
    end

    test "field-level validation prevents channel from being created" do
      {:error, message} = Chat.Contract.create_channel(nil)

      assert "Can't create channel without name." == message
    end

    test "duplication prevents channel from being created" do
      {:ok, _} = Chat.Contract.create_channel("xyz")
      {:error, message} = Chat.Contract.create_channel("xyz")

      assert "Channel has not been created." == message
    end

    test "created channel is the same as received" do
      {:ok, inserted} = Chat.Contract.create_channel("xyz")
      {:ok, retrieved} = Chat.Contract.get_channel("xyz")

      assert inserted.name == retrieved.name
      assert inserted.is_private == retrieved.is_private
      assert inserted.is_deleted == retrieved.is_deleted
    end

    test "created channel is being found" do
      {:ok, inserted} = Chat.Contract.create_channel("xyz")
      [ retrieved ] = Chat.Contract.get_all_channels()

      assert inserted.name == retrieved.name
      assert inserted.is_private == retrieved.is_private
      assert inserted.is_deleted == retrieved.is_deleted
    end

    test "no users in a new channel" do
      {:ok, _} = Chat.Contract.create_channel("xyz")
      users = Chat.Contract.get_all_users_in_channel("xyz")

      assert length(users) == 0
    end

    test "user is present in a joined channel" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)

      [ retrieved ] = Chat.Contract.get_all_users_in_channel("xyz")

      assert user.name == retrieved.name
      assert user.description == retrieved.description
      assert user.is_active == retrieved.is_active
      assert user.is_deleted == retrieved.is_deleted
    end

    test "can verify user's present in channel if joined" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)

      is_in_channel = Chat.Contract.is_user_in_channel("xyz", "abc")
      assert true == is_in_channel
    end

    test "can verify user's presence in channel when not joined" do
      {:ok, _} = Chat.Contract.create_channel("xyz")
      {:ok, _} = People.Contract.create_user("abc", "abc desc")

      is_in_channel = Chat.Contract.is_user_in_channel("xyz", "abc")
      assert false == is_in_channel
    end

    test "user can't join a channel twice" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)
      {:error, message} = Chat.Contract.join_channel(channel.name, user.name)

      assert "User already in channel." == message
    end

    test "two users properly join channel" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user1} = People.Contract.create_user("abc", "abc desc")
      {:ok, user2} = People.Contract.create_user("def", "def desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user1.name)
      {:ok, _} = Chat.Contract.join_channel(channel.name, user2.name)

      retrieved = Chat.Contract.get_all_users_in_channel("xyz")
      assert 2 == Enum.count(retrieved)
      assert true == Chat.Contract.is_user_in_channel("xyz", "abc")
      assert true == Chat.Contract.is_user_in_channel("xyz", "def")
    end

    test "user properly leaves channel" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)
      {:ok, _} = Chat.Contract.leave_channel(channel.name, user.name)

      [] = Chat.Contract.get_all_users_in_channel("xyz")
    end

    test "can verify user's presence in channel if left" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)
      {:ok, _} = Chat.Contract.leave_channel(channel.name, user.name)

      assert false == Chat.Contract.is_user_in_channel("xyz", "abc")
    end

    test "user can't leave a channel he's not in" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:error, message} = Chat.Contract.leave_channel(channel.name, user.name)

      assert "User not present in the channel." == message
    end

    test "user can't leave a channel he's already left" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)
      {:ok, _} = Chat.Contract.leave_channel(channel.name, user.name)
      {:error, message} = Chat.Contract.leave_channel(channel.name, user.name)

      assert "User not present in the channel." == message
    end

    test "user can't join a non-existing channel" do
      {:ok, _} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:error, message} = Chat.Contract.join_channel("def", user.name)

      assert "User cannot join this particular channel." == message

    end

    test "user can't leave a non-existing channel" do
      {:ok, channel} = Chat.Contract.create_channel("xyz")
      {:ok, user} = People.Contract.create_user("abc", "abc desc")
      {:ok, _} = Chat.Contract.join_channel(channel.name, user.name)
      {:error, message} = Chat.Contract.leave_channel("def", user.name)

      assert "Can't remove user from such channel." == message
    end

    test "non-existing user can't join a channel" do

    end

    test "non-existing user can't leave a channel" do

    end
  end
end
