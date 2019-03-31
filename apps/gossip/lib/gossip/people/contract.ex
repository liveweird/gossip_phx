defmodule People.Contract do

  defdelegate create_user(name, description), to: People.Service
  defdelegate get_active_users, to: People.Service
  defdelegate get_user(name), to: People.Service

end
