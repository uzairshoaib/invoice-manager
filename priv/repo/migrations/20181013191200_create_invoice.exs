defmodule InvoiceManager.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :title, :string
      add :date, :date
      add :type_id, references(:invoice_types, on_delete: :nothing)
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:invoices, [:type_id])
    create index(:invoices, [:client_id])
  end
end
