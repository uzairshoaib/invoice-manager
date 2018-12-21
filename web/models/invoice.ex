defmodule InvoiceManager.Invoice do
  use InvoiceManager.Web, :model

  schema "invoices" do
    field :title, :string
    belongs_to :type, InvoiceManager.InvoiceType, foreign_key: :type_id
    belongs_to :client, InvoiceManager.Client, foreign_key: :client_id
    has_many :items, InvoiceManager.InvoiceItem, foreign_key: :invoice_id, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :client_id, :type_id])
    |> validate_required([:title, :client_id, :type_id])
    |> foreign_key_constraint(:client_id)
    |> cast_assoc(:items)
  end
end
