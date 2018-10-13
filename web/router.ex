defmodule InvoiceManager.Router do
  use InvoiceManager.Web, :router

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

  scope "/", InvoiceManager do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  scope "/manage", InvoiceManager do
    pipe_through :browser

    resources "/clients", ClientController
  end

  # Other scopes may use custom stacks.
  # scope "/api", InvoiceManager do
  #   pipe_through :api
  # end
end
