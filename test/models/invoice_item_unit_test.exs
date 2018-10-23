defmodule InvoiceManager.InvoiceItemUnitTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.InvoiceItemUnit

  @valid_attrs %{title: "some title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = InvoiceItemUnit.changeset(%InvoiceItemUnit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = InvoiceItemUnit.changeset(%InvoiceItemUnit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
