defmodule InvoiceManager.ClientTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.Client

  @valid_attrs %{company: "some company", designation: "some designation", email: "some email", name: "some name", phone: "some phone", status: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Client.changeset(%Client{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Client.changeset(%Client{}, @invalid_attrs)
    refute changeset.valid?
  end
end
