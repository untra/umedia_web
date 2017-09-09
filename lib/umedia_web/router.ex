defmodule UmediaWeb.Router do
  use UmediaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UmediaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/upload", UploadController, :index
    resources "/shows", ShowController
    resources "/franchises", FranchiseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", UmediaWeb do
  #   pipe_through :api
  # end
end
