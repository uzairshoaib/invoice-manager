defmodule InvoiceManager.LedgerController do
	use InvoiceManager.Web, :controller
	alias InvoiceManager.Invoice
	alias InvoiceManager.Client
	import Ecto.Query

	def index(conn, _params) do
		clients = Repo.all(Client)
		render conn, "index.html", clients: clients
	end

	def show(conn, %{"id" => id}) do
		query = from i in Invoice, where: i.client_id == ^id
		invoices = Repo.all(query)
								|> Repo.preload([items: [:unit], client: [], type: []])
		render conn, "show.html", invoices: invoices
	end

end