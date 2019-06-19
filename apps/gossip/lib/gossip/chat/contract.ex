defmodule Chat.Contract do

  @spec get_all_channels() :: list(%Chat.Channel{})
  defdelegate get_all_channels, to: Chat.Service

  @spec create_channel(String.t()) :: {:ok, %Chat.Channel{}} | {:error, String.t()}
  defdelegate create_channel(channel_name), to: Chat.Service

  @spec get_channel(String.t()) :: {:ok, %Chat.Channel{}} | {:error, String.t()}
  defdelegate get_channel(channel_name), to: Chat.Service

  @spec join_channel(String.t(), String.t()) :: {:ok, %Chat.Channel{}} | {:error, String.t()}
  defdelegate join_channel(channel_name, user_name), to: Chat.Service

  @spec leave_channel(String.t(), String.t()) :: {:ok, %Chat.Channel{}} | {:error, String.t()}
  defdelegate leave_channel(channel_name, user_name), to: Chat.Service

  @spec is_user_in_channel(String.t(), String.t()) :: true | false
  defdelegate is_user_in_channel(channel_name, user_name), to: Chat.Service

  @spec get_all_users_in_channel(String.t()) :: list(%People.User{})
  defdelegate get_all_users_in_channel(channel_name), to: Chat.Service
end
