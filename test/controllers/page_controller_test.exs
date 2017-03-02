defmodule GossipPhx.PageControllerTest do
  use GossipPhx.ConnCase

  test "GET /swagger.json", %{conn: conn} do
    conn = get conn, "/swagger.json"
    body = json_response(conn, 200)
    assert body["swagger"] == "2.0"
  end
end
