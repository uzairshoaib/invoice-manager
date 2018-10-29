defmodule InvoiceManager.SessionController do
	use InvoiceManager.Web, :controller

	def new(conn, _) do
		render conn, "new.html"
	end

	def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
		case InvoiceManager.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
			{:ok, conn} ->
				conn
				|> put_flash(:info, "Welcome Back")
				|> redirect(to: page_path(conn, :index))
			{:error, _reason, conn} ->
				conn
				|> put_flash(:error, "Invalid Username/Password combination")
				|> render("new.html")
		end
	end

	def delete(conn, _) do
		conn
		|> InvoiceManager.Auth.logout()
		|> redirect(to: session_path(conn, :new))
	end
end