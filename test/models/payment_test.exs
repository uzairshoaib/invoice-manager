defmodule InvoiceManager.PaymentTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.Payment

  @valid_attrs %{amount: "120.5", date: ~D[2010-04-17]}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Payment.changeset(%Payment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Payment.changeset(%Payment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
