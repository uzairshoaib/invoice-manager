defmodule InvoiceManager.PageController do
  use InvoiceManager.Web, :controller
  import InvoiceManager.Auth, only: [authenticate_user: 2]
  plug :authenticate_user
  
  def index(conn, _params) do
    render conn, "index.html"
  end
end
