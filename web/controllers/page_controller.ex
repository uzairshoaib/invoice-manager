defmodule InvoiceManager.PageController do
  use InvoiceManager.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
