defmodule GossipPhx.Web.Channel do
  @moduledoc """
  Basic channel model - key info that do not involve chatting history or current users
  """

  use GossipPhx.Web, :model

  schema "channels" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(%{}, %{}) :: any()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
