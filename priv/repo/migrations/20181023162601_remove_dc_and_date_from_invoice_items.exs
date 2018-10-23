defmodule InvoiceManager.Repo.Migrations.RemoveDcAndDateFromInvoiceItems do
  use Ecto.Migration

  def change do
  	alter table(:invoice_items) do
  		remove :dc
  		remove :date
  	end
  end
end
