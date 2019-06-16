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
      Chat.Contract.join_channel(channel.name, user.name)

      [ retrieved ] = Chat.Contract.get_all_users_in_channel("xyz")

      assert user.name == retrieved.name
      assert user.description == retrieved.description
      assert user.is_active == retrieved.is_active
      assert user.is_deleted == retrieved.is_deleted
    end

    test "user can't join a channel twice" do

    end

    test "two users properly join channel" do

    end

    test "user properly leaves channel" do

    end

    test "user can't leave a non-existing channel" do

    end

    test "user can't leave a channel he's not in" do

    end

    test "non-existing user can't join a channel" do

    end

  end
end
