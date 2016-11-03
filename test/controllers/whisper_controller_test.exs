defmodule GossipPhx.WhisperControllerTest do
  use GossipPhx.ConnCase

  alias GossipPhx.Whisper
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, whisper_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing whispers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, whisper_path(conn, :new)
    assert html_response(conn, 200) =~ "New whisper"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, whisper_path(conn, :create), whisper: @valid_attrs
    assert redirected_to(conn) == whisper_path(conn, :index)
    assert Repo.get_by(Whisper, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, whisper_path(conn, :create), whisper: @invalid_attrs
    assert html_response(conn, 200) =~ "New whisper"
  end

  test "shows chosen resource", %{conn: conn} do
    whisper = Repo.insert! %Whisper{}
    conn = get conn, whisper_path(conn, :show, whisper)
    assert html_response(conn, 200) =~ "Show whisper"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, whisper_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    whisper = Repo.insert! %Whisper{}
    conn = get conn, whisper_path(conn, :edit, whisper)
    assert html_response(conn, 200) =~ "Edit whisper"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    whisper = Repo.insert! %Whisper{}
    conn = put conn, whisper_path(conn, :update, whisper), whisper: @valid_attrs
    assert redirected_to(conn) == whisper_path(conn, :show, whisper)
    assert Repo.get_by(Whisper, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    whisper = Repo.insert! %Whisper{}
    conn = put conn, whisper_path(conn, :update, whisper), whisper: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit whisper"
  end

  test "deletes chosen resource", %{conn: conn} do
    whisper = Repo.insert! %Whisper{}
    conn = delete conn, whisper_path(conn, :delete, whisper)
    assert redirected_to(conn) == whisper_path(conn, :index)
    refute Repo.get(Whisper, whisper.id)
  end
end
