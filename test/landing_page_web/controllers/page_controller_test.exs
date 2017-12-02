defmodule LandingPageWeb.PageControllerTest do
  use LandingPageWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Phoenix & Elm landing page"
  end
end
