defmodule Chat.ActiveUser do
  @moduledoc """
  Replica of an active user.
  """

  use Ecto.Schema

  @schema_prefix "chat"
  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  schema "active_users" do
    field :name, :string
    field :description, :string
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :description])
    |> Ecto.Changeset.validate_required([:name, :description])
  end
end
