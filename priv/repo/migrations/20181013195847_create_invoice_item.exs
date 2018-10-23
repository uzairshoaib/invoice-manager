defmodule InvoiceManager.Repo.Migrations.CreateInvoiceItem do
  use Ecto.Migration

  def change do
    create table(:invoice_items) do
      add :serial_number, :integer
      add :description, :text
      add :dc, :integer
      add :date, :date
      add :quantity, :decimal
      add :price, :decimal
      add :amount, :decimal
      add :unit_id, references(:invoice_item_units, on_delete: :nothing)

      timestamps()
    end

    create index(:invoice_items, [:unit_id])
  end
end
