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

    test "created user is the same as received" do
      {:ok, inserted} = Chat.Contract.create_channel("xyz")
      {:ok, retrieved} = Chat.Contract.get_channel("xyz")

      assert inserted.name == retrieved.name
      assert inserted.is_private == retrieved.is_private
      assert inserted.is_deleted == retrieved.is_deleted
    end

  end
end
