defmodule GossipPhx.RedisApi do
  import GossipPhx.Whisper
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

  def add_whisper(content) do
    GenServer.call(:redis, {:add_whisper, content})
  end

  def get_whispers() do
    GenServer.call(:redis, {:get_whispers})
  end

  def clean_whispers() do
    GenServer.call(:redis, {:clean_whispers})
  end

  def handle_call({:add_whisper, content}, _from, state) do
    new_whisper =
      content
      |> Map.get("content")
    client =
      state
      |> Map.get(:client)
    client
    |> Redix.command(["LPUSH", "whispers", new_whisper])
    client
    |> Redix.command(["LTRIM", "whispers", 0, 10])
    {:reply, :ok, state}
  end

  def handle_call({:get_whispers}, _from, state) do
    {:ok, unmapped} =
      state
      |> Map.get(:client)
      |> Redix.command(["LRANGE", "whispers", 0, 10])
    whispers =
      unmapped
      |> Enum.map(fn x -> whisper(content: x) end)
    {:reply, whispers, state}
  end

  def handle_call({:clean_whispers}, _from, state) do
    client =
      state
      |> Map.get(:client)
    client
    |> Redix.command(["LTRIM", "whispers", 100, 101])
    {:reply, :ok, state}
  end
end
