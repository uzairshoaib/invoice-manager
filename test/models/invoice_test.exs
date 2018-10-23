defmodule InvoiceManager.InvoiceTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.Invoice

  @valid_attrs %{date: ~D[2010-04-17], title: "some title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Invoice.changeset(%Invoice{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Invoice.changeset(%Invoice{}, @invalid_attrs)
    refute changeset.valid?
  end
end
