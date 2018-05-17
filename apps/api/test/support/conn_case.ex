defmodule Api.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import Api.Router.Helpers
      @endpoint Api.Endpoint
    end
  end

  setup _tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Backoffice.Repo)
    conn = Phoenix.ConnTest.build_conn()

    {:ok, conn: conn}
  end
end
