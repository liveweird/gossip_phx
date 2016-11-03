defmodule GossipPhx.WhisperController do
  use GossipPhx.Web, :controller

  def index(conn, _params) do
    whispers = GossipPhx.RedisApi.get_whispers
    render(conn, "index.html", whispers: whispers)
  end

  def create(conn, %{"new_whisper" => new_whisper}) do
    GossipPhx.RedisApi.add_whisper(new_whisper)
    conn
    |> redirect(to: whisper_path(conn, :index))
  end

end
