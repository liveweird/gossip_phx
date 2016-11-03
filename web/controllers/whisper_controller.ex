defmodule GossipPhx.WhisperController do
  use GossipPhx.Web, :controller
  import GossipPhx.Whisper

  def index(conn, _params) do
    whispers = [whisper(), whisper()]
    render(conn, "index.html", whispers: whispers)
  end

  def create(conn, %{"new_whisper" => whisper_params}) do
    conn
    |> redirect(to: whisper_path(conn, :index))
#    changeset = Whisper.changeset(%Whisper{}, whisper_params)
#
#    case Repo.insert(changeset) do
#      {:ok, _whisper} ->
#        conn
#        |> put_flash(:info, "Whisper created successfully.")
#        |> redirect(to: whisper_path(conn, :index))
#      {:error, changeset} ->
#        render(conn, "new.html", changeset: changeset)
#    end
  end

end
