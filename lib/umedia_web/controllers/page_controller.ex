defmodule UmediaWeb.PageController do
  use UmediaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
