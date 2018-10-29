defmodule InvoiceManager.Web do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use InvoiceManager.Web, :controller
      use InvoiceManager.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias InvoiceManager.Repo
      import Ecto
      import Ecto.Query

      import InvoiceManager.Router.Helpers
      import InvoiceManager.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import InvoiceManager.Router.Helpers
      import InvoiceManager.ErrorHelpers
      import InvoiceManager.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import InvoiceManager.Auth, only: [authenticate_user: 2] # new import
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias InvoiceManager.Repo
      import Ecto
      import Ecto.Query
      import InvoiceManager.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
