defmodule InvoiceManager.InvoiceItemControllerTest do
  use InvoiceManager.ConnCase

  alias InvoiceManager.InvoiceItem
  @valid_attrs %{amount: "120.5", date: ~D[2010-04-17], dc: 42, description: "some description", price: "120.5", quantity: "120.5", serial_number: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invoice_item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing invoice items"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, invoice_item_path(conn, :new)
    assert html_response(conn, 200) =~ "New invoice item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, invoice_item_path(conn, :create), invoice_item: @valid_attrs
    invoice_item = Repo.get_by!(InvoiceItem, @valid_attrs)
    assert redirected_to(conn) == invoice_item_path(conn, :show, invoice_item.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invoice_item_path(conn, :create), invoice_item: @invalid_attrs
    assert html_response(conn, 200) =~ "New invoice item"
  end

  test "shows chosen resource", %{conn: conn} do
    invoice_item = Repo.insert! %InvoiceItem{}
    conn = get conn, invoice_item_path(conn, :show, invoice_item)
    assert html_response(conn, 200) =~ "Show invoice item"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, invoice_item_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    invoice_item = Repo.insert! %InvoiceItem{}
    conn = get conn, invoice_item_path(conn, :edit, invoice_item)
    assert html_response(conn, 200) =~ "Edit invoice item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    invoice_item = Repo.insert! %InvoiceItem{}
    conn = put conn, invoice_item_path(conn, :update, invoice_item), invoice_item: @valid_attrs
    assert redirected_to(conn) == invoice_item_path(conn, :show, invoice_item)
    assert Repo.get_by(InvoiceItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invoice_item = Repo.insert! %InvoiceItem{}
    conn = put conn, invoice_item_path(conn, :update, invoice_item), invoice_item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit invoice item"
  end

  test "deletes chosen resource", %{conn: conn} do
    invoice_item = Repo.insert! %InvoiceItem{}
    conn = delete conn, invoice_item_path(conn, :delete, invoice_item)
    assert redirected_to(conn) == invoice_item_path(conn, :index)
    refute Repo.get(InvoiceItem, invoice_item.id)
  end
end
