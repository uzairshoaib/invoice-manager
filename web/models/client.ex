defmodule InvoiceManager.Client do
  use InvoiceManager.Web, :model

  schema "client" do
    field :name, :string
    field :email, :string
    field :phone, :string
    field :company, :string
    field :designation, :string
    field :status, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :phone, :company, :designation, :status])
    |> validate_required([:name, :email, :phone, :company, :designation, :status])
    |> unique_constraint(:email)
  end
end
