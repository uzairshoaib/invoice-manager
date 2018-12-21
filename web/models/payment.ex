defmodule InvoiceManager.Payment do
  use InvoiceManager.Web, :model

  schema "payments" do
    field :date, :date
    field :amount, :decimal
    belongs_to :client, InvoiceManager.Client, foreign_key: :client_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date, :amount, :client_id])
    |> validate_required([:date, :amount, :client_id])
    |> foreign_key_constraint(:client_id)
  end
end
