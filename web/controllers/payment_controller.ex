defmodule InvoiceManager.PaymentController do
  use InvoiceManager.Web, :controller

  alias InvoiceManager.Payment
  alias InvoiceManager.Client
  import Ecto.Query

  plug :load_clients when action in [:new, :create, :edit, :update]

  defp load_clients(conn, _params) do
    query = from c in Client, select: {c.name, c.id}, order_by: c.name
    clients = Repo.all(query)
    assign(conn, :clients, clients)
  end

  def index(conn, _params) do
    payments = Repo.all(Payment)
                |> Repo.preload([:client])
    render(conn, "index.html", payments: payments)
  end

  def new(conn, _params) do
    changeset = Payment.changeset(%Payment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"payment" => payment_params}) do
    changeset = Payment.changeset(%Payment{}, payment_params)

    case Repo.insert(changeset) do
      {:ok, payment} ->
        payment = payment
                  |> Repo.preload([:client])
        # update client balance
        client_new_balance = (Decimal.to_float(payment.client.balance) - Decimal.to_float(payment.amount))
        client_changeset = Client.changeset(payment.client, %{"balance" => client_new_balance})
        Repo.update(client_changeset)
        # redirect
        conn
        |> put_flash(:info, "Payment created successfully.")
        |> redirect(to: payment_path(conn, :show, payment))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)
              |> Repo.preload(:client)
    render(conn, "show.html", payment: payment)
  end

  def edit(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)
    changeset = Payment.changeset(payment)
    render(conn, "edit.html", payment: payment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Repo.get!(Payment, id)
    changeset = Payment.changeset(payment, payment_params)

    case Repo.update(changeset) do
      {:ok, payment} ->
        conn
        |> put_flash(:info, "Payment updated successfully.")
        |> redirect(to: payment_path(conn, :show, payment))
      {:error, changeset} ->
        render(conn, "edit.html", payment: payment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(payment)

    conn
    |> put_flash(:info, "Payment deleted successfully.")
    |> redirect(to: payment_path(conn, :index))
  end
end
