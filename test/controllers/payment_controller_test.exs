defmodule InvoiceManager.PaymentControllerTest do
  use InvoiceManager.ConnCase

  alias InvoiceManager.Payment
  @valid_attrs %{amount: "120.5", date: ~D[2010-04-17]}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, payment_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing payments"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, payment_path(conn, :new)
    assert html_response(conn, 200) =~ "New payment"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, payment_path(conn, :create), payment: @valid_attrs
    payment = Repo.get_by!(Payment, @valid_attrs)
    assert redirected_to(conn) == payment_path(conn, :show, payment.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, payment_path(conn, :create), payment: @invalid_attrs
    assert html_response(conn, 200) =~ "New payment"
  end

  test "shows chosen resource", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = get conn, payment_path(conn, :show, payment)
    assert html_response(conn, 200) =~ "Show payment"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, payment_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = get conn, payment_path(conn, :edit, payment)
    assert html_response(conn, 200) =~ "Edit payment"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = put conn, payment_path(conn, :update, payment), payment: @valid_attrs
    assert redirected_to(conn) == payment_path(conn, :show, payment)
    assert Repo.get_by(Payment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = put conn, payment_path(conn, :update, payment), payment: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit payment"
  end

  test "deletes chosen resource", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = delete conn, payment_path(conn, :delete, payment)
    assert redirected_to(conn) == payment_path(conn, :index)
    refute Repo.get(Payment, payment.id)
  end
end
