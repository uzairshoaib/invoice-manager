defmodule InvoiceManager.Router do
  use InvoiceManager.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InvoiceManager.Auth, repo: InvoiceManager.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # session layout pipeline
  pipeline :session_layout do
    plug :put_layout, {InvoiceManager.LayoutView, :session}
  end

  scope "/", InvoiceManager do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", InvoiceManager do
    pipe_through [:browser, :session_layout]
    
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/manage", InvoiceManager do
    pipe_through [:browser, :authenticate_user]

    resources "/clients", ClientController
    resources "/invoices", InvoiceController
    resources "/payments", PaymentController
    get "/ledgers", LedgerController, :index
    get "/ledgers/:id", LedgerController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", InvoiceManager do
  #   pipe_through :api
  # end
end
