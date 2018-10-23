defmodule InvoiceManager.Repo.Migrations.RemoveDateFromInvoices do
  use Ecto.Migration

  def change do
  	alter table(:invoices) do
  		remove :date
  	end
  end
end
