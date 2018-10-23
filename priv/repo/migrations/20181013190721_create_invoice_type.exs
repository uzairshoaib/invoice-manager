defmodule InvoiceManager.Repo.Migrations.CreateInvoiceType do
  use Ecto.Migration

  def change do
    create table(:invoice_types) do
      add :title, :string

      timestamps()
    end
  end
end
