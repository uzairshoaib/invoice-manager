defmodule InvoiceManager.Repo.Migrations.AddInvoiceIdToInvoiceItems do
  use Ecto.Migration

  def change do
  	alter table(:invoice_items) do
  		add :invoice_id, references(:invoices, on_delete: :nothing)
  	end

  	create index(:invoice_items, [:invoice_id])
  end
end
