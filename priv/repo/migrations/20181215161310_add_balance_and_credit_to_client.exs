defmodule InvoiceManager.Repo.Migrations.AddBalanceAndCreditToClient do
  use Ecto.Migration

  def change do
  	alter table(:clients) do
  		add :balance, :decimal, default: 0
  		add :credit, :decimal, default: 0
  	end
  end
end
