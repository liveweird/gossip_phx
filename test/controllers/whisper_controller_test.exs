defmodule GossipPhx.WhisperControllerTest do
  use GossipPhx.ConnCase

  alias GossipPhx.Whisper
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, whisper_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing whispers"
  end

  test "creates resource and displays it on the list", %{conn: conn} do
    conn = post conn, whisper_path(conn, :create), new_whisper: @valid_attrs
    # assert Repo.get_by(Whisper, @valid_attrs)
  end
end
