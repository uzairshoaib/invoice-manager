defmodule InvoiceManager.InvoiceItem do
  use InvoiceManager.Web, :model

  schema "invoice_items" do
    field :serial_number, :integer
    field :description, :string
    field :quantity, :decimal
    field :price, :decimal
    field :amount, :decimal
    belongs_to :unit, InvoiceManager.InvoiceItemUnit, foreign_key: :unit_id
    belongs_to :invoice, InvoiceManager.Invoice, foreign_key: :invoice_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :quantity, :price, :amount, :unit_id])
    |> validate_required([:description, :quantity, :price, :amount, :unit_id])
  end
end
