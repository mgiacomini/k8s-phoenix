defmodule Api.AppController do
  use Api, :controller
  alias Backoffice.Auth

  def authenticate(conn, %{"app_id" => app_id, "app_secret" => app_secret}) do
    Auth.authenticate_app(%{app_id: app_id, app_secret: app_secret})
    |> case do
      {:ok, app} ->
        conn
        |> put_status(:ok)
        |> json(%{data: %{token: app.token}})

      {:error, _message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{})
    end
  end
end
