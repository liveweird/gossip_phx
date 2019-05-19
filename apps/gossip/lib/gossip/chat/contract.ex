defmodule Chat.Contract do

  defdelegate get_all_channels, to: Chat.Service
  defdelegate create_channel(channel_name), to: Chat.Service
  defdelegate get_channel(channel_name), to: Chat.Service
  defdelegate join_channel(channel_name, user_name), to: Chat.Service
  # defdelegate leave_channel(channel_name, user_name), to: Chat.Service

end
