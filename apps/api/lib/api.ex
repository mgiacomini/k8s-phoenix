defmodule Api do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ApiWeb, :controller
      use ApiWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def schema_type do
    quote do
      use Absinthe.Schema.Notation
      use Absinthe.Ecto, repo: Backoffice.Repo
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: Web
      import Plug.Conn
      import Api.Router.Helpers
    end
  end

  def view do
    quote do
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
      import Api.Router.Helpers
      import Api.ErrorHelpers
      import Api.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
