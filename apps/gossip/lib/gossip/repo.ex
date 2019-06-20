defmodule Gossip.Repo do
  @moduledoc """
  SQL repository shared across all the modules.
  """

  use Ecto.Repo,
    otp_app: :gossip,
    adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
