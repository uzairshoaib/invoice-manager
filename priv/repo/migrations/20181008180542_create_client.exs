defmodule InvoiceManager.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :company, :string
      add :designation, :string
      add :status, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:clients, [:email])
  end
end
