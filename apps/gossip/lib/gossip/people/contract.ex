defmodule People.Contract do
  @moduledoc """
  Public contract of whole people module.
  """

  @spec create_user(String.t(), String.t()) :: {:ok, %People.User{}} | {:error, String.t()}
  defdelegate create_user(user_name, user_description), to: People.Service

  @spec get_active_users() :: list(%People.User{})
  defdelegate get_active_users, to: People.Service

  @spec get_user(String.t()) :: {:ok, %People.User{}} | {:error, String.t()}
  defdelegate get_user(user_name), to: People.Service

  @spec block_user(String.t()) :: {:ok, %People.User{}} | {:error, String.t()}
  defdelegate block_user(user_name), to: People.Service
end
