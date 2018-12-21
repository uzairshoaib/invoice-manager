defmodule InvoiceManager.InvoiceController do
  use InvoiceManager.Web, :controller

  alias InvoiceManager.Invoice
  alias InvoiceManager.InvoiceType
  alias InvoiceManager.Client
  alias InvoiceManager.InvoiceItemUnit
  alias InvoiceManager.InvoiceItem
  import Ecto.Query

  plug :load_types when action in [:new, :create, :edit, :update]
  plug :load_clients when action in [:new, :create, :edit, :update]
  plug :load_item_units when action in [:new, :create, :edit, :update]

  def load_types(conn, _params) do
    query = from t in InvoiceType, select: {t.title, t.id}, order_by: t.title
    types = Repo.all query
    assign(conn, :types, types)
  end

  def load_clients(conn, _params) do
    query = from c in Client, select: {c.name, c.id}, order_by: c.name
    clients = Repo.all query
    assign(conn, :clients, clients)
  end

  def load_item_units(conn, _params) do
    query = from u in InvoiceItemUnit, select: {u.title, u.id}, order_by: u.title
    units = Repo.all query
    assign(conn, :units, units)
  end

  def index(conn, _params) do
    invoices = Repo.all(Invoice)
              |> Repo.preload([:client, :type])
    render(conn, "index.html", invoices: invoices)
  end

  def new(conn, _params) do
    changeset = Invoice.changeset(%Invoice{
      items: [
        %InvoiceItem{}
      ]
    })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invoice" => invoice_params}) do
    changeset = Invoice.changeset(%Invoice{}, invoice_params)

    case Repo.insert(changeset) do
      {:ok, invoice} ->
        invoice = invoice 
                  |> Repo.preload([:client, :items])
        # calculate invoice amount
        invoice_amount = Enum.map(invoice.items, fn i -> Decimal.to_float(i.amount) end)
                          |> Enum.sum
        # update client balance
        client_new_balance = (Decimal.to_float(invoice.client.balance) + invoice_amount)
        client_changeset = Client.changeset(invoice.client, %{"balance" => client_new_balance})
        Repo.update(client_changeset)
        # redirect
        conn
        |> put_flash(:info, "Invoice created successfully.")
        |> redirect(to: invoice_path(conn, :show, invoice))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice = Repo.get!(Invoice, id)
              |> Repo.preload([items: [:unit], client: [], type: []])
    render(conn, "show.html", invoice: invoice)
  end

  def edit(conn, %{"id" => id}) do
    invoice = Repo.get!(Invoice, id)
              |> Repo.preload([:items])
    changeset = Invoice.changeset(invoice)
    render(conn, "edit.html", invoice: invoice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Repo.get!(Invoice, id)
                |> Repo.preload(:items)
    changeset = Invoice.changeset(invoice, invoice_params)

    case Repo.update(changeset) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice updated successfully.")
        |> redirect(to: invoice_path(conn, :show, invoice))
      {:error, changeset} ->
        render(conn, "edit.html", invoice: invoice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Repo.get!(Invoice, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(invoice)

    conn
    |> put_flash(:info, "Invoice deleted successfully.")
    |> redirect(to: invoice_path(conn, :index))
  end
end
