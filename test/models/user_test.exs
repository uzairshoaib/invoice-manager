defmodule InvoiceManager.UserTest do
  use InvoiceManager.ModelCase

  alias InvoiceManager.User

  @valid_attrs %{email: "some email", name: "some name", password_hash: "some password_hash"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
