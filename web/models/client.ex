defmodule InvoiceManager.Client do
  use InvoiceManager.Web, :model

  schema "clients" do
    field :name, :string
    field :email, :string
    field :phone, :string
    field :company, :string
    field :designation, :string
    field :status, :boolean, default: false
    field :balance, :decimal, default: 0
    field :credit, :decimal, default: 0
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :phone, :company, :designation, :status, :balance, :credit])
    |> validate_required([:name, :email, :phone, :company, :designation, :status])
    |> unique_constraint(:email)
  end
end
