defmodule Chat.ChannelTest do
  use Gossip.DataCase

  describe "channels" do

    test "empty list of channels" do
      channels = Chat.Contract.get_all_channels()

      assert length(channels) == 0
    end
  end
end
