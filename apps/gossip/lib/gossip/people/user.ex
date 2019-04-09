defmodule People.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :user_name, :string
    field :description, :string
    field :is_active, :boolean, default: true
    field :is_deleted, :boolean, default: false
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:user_name, :description, :is_active, :is_deleted])
    |> Ecto.Changeset.validate_required([:user_name, :description, :is_active, :is_deleted])
  end
end