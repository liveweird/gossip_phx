defmodule SideEffects do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok)
  end

  ## public interface
  def purge_events(server) do
    GenServer.call(server, {:purge_events})
  end

  def register_event(server, event_id) do
    GenServer.call(server, {:register_event, event_id})
  end

  def register_handler(server, event_id, handler) do
    GenServer.call(server, {:register_handler, event_id, handler})
  end

  @spec raise_event(atom() | pid() | {atom(), any()} | {:via, atom(), any()}, any(), any()) ::
          any()
  def raise_event(server, event_id, payload) do
    GenServer.call(server, {:raise_event, event_id, payload})
  end

  ## server callbacks
  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:purge_events}, _from, _event_map) do
    {:reply, :ok, %{}}
  end

  @impl true
  def handle_call({:register_event, event_id}, _from, event_map) do
    if Map.has_key?(event_map, event_id) do
      {:reply, {:error, "Event already exists"}, event_map}
    else
      {:reply, :ok, Map.put(event_map, event_id, [])}
    end
  end

  @impl true
  def handle_call({:register_handler, event_id, handler}, _from, event_map) do
    if Map.has_key?(event_map, event_id) do
      handlers = Map.fetch(event_map, event_id)
      updated_handlers = handlers ++ [handler]
      updated_map = %{event_map | event_id: updated_handlers}
      {:reply, :ok, updated_map}
    else
      {:reply, {:error, "Event is not registered"}, event_map}
    end
  end

  @impl true
  def handle_call({:raise_event, event_id, payload}, _from, event_map) do
    if Map.has_key?(event_map, event_id) do
      handlers = Map.fetch(event_map, event_id)
      handlers
      |> Enum.each(fn handler ->
        handler.(payload)
      end)
      {:reply, :ok, event_map}
    else
      {:reply, {:error, "Event is not registered"}, event_map}
    end
  end

end
