defmodule InvoiceManager.InvoiceItemTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.InvoiceItem

  @valid_attrs %{amount: "120.5", date: ~D[2010-04-17], dc: 42, description: "some description", price: "120.5", quantity: "120.5", serial_number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = InvoiceItem.changeset(%InvoiceItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = InvoiceItem.changeset(%InvoiceItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
