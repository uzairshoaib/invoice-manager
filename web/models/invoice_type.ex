defmodule InvoiceManager.InvoiceType do
  use InvoiceManager.Web, :model

  schema "invoice_types" do
    field :title, :string
    has_many :invoices, InvoiceManager.Invoice, foreign_key: :type_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
