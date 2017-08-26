defmodule UmediaWeb.UploadController do
  @moduledoc """
  File Upload Controller
  """
  use UmediaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
