defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(
      conn
      |> assign(:query, :query),
      "index.html"
    )
  end
end
