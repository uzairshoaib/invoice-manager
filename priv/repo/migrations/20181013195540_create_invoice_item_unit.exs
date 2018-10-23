defmodule InvoiceManager.Repo.Migrations.CreateInvoiceItemUnit do
  use Ecto.Migration

  def change do
    create table(:invoice_item_units) do
      add :title, :string

      timestamps()
    end
  end
end
