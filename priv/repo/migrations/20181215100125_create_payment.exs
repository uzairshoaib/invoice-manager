defmodule InvoiceManager.Repo.Migrations.CreatePayment do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :date, :date
      add :amount, :decimal
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:payments, [:client_id])
  end
end
