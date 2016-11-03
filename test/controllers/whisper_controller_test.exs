defmodule GossipPhx.WhisperControllerTest do
  use GossipPhx.ConnCase
  import GossipPhx.Whisper

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  setup do
    GossipPhx.RedisApi.clean_whispers()
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, whisper_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing whispers"
  end

  test "creates resource and displays it on the list", %{conn: conn} do
    assert GossipPhx.RedisApi.get_whispers == []
    post conn, whisper_path(conn, :create), new_whisper: @valid_attrs
    whispers = GossipPhx.RedisApi.get_whispers
    assert Enum.count(whispers) == 1
    assert whisper(List.first(whispers), :content) == Map.get(@valid_attrs, :content)
  end
end
