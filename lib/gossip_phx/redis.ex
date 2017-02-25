defmodule GossipPhx.RedisApi do
  use GenServer
  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: :redis])
  end

  def init(nil) do
    config = Application.get_env(:gossip_phx, GossipPhx.RedisApi)
    {:ok, client} = Redix.start_link(host: config[:host],
      port: config[:port],
#      password: config[:password],
      database: config[:database])
    {:ok, %{ client: client }}
  end

  def terminate(_, state) do
    state
    |> Map.get(:client)
    |> Redix.stop
  end
end
