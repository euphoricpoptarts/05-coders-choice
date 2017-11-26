defmodule WebFrontend.PageController do
  use WebFrontend.Web, :controller

  def index(conn, %{ "query" => query }) do
    render conn, "index.html", result: Parser.parse(query), render: true
  end

  def index(conn, _params) do
    render conn, "index.html", result: "No query given", render: false
  end
end
