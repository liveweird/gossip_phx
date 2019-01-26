defmodule People.User do
  use Ecto.Schema

  schema "user" do
    @primary_key {:id, :binary_id, autogenerate: true}
    field :user_name, :string
    field :description, :string
    field :is_active, :boolean, default: true
    field :is_delected, :boolean, default: false
    timestamps()
  end
end
