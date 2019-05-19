defmodule People.Contract do

  defdelegate create_user(user_name, user_description), to: People.Service
  defdelegate get_active_users, to: People.Service
  defdelegate get_user(user_name), to: People.Service
  defdelegate block_user(user_name), to: People.Service

end
