defmodule GossipPhx.RedisApi do
  @moduledoc """
  Redis access
  """

  use GenServer
  require Logger

  @spec start_link() :: pid()
  def start_link do
    GenServer.start_link(__MODULE__, nil, [name: :redis])
  end

  @spec init(any()) :: {:atom, any()}
  def init(nil) do
    config = Application.get_env(:gossip_phx, GossipPhx.RedisApi)
    {:ok, client} = Redix.start_link(host: config[:host],
      port: config[:port],
#      password: config[:password],
      database: config[:database])
    {:ok, %{client: client}}
  end

  @spec terminate(any(), tuple()) :: tuple()
  def terminate(_, state) do
    state
    |> Map.get(:client)
    |> Redix.stop
  end
end
