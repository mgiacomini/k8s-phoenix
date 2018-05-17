defmodule Api.Plugs.Authentication do
  @behaviour Plug

  import Plug.Conn

  alias Backoffice.Auth
  alias Backoffice.Auth.{Organization, App}

  def init(opts), do: opts

  def call(conn, _) do
    case authenticate(conn) do
      {:ok, current_organization, current_app} ->
        conn
        |> put_private(:absinthe, context(current_organization, current_app))
        |> put_private(:organization, current_organization)

      {:error, _reason} ->
        conn
        |> unauthorized_response()
    end
  end

  defp context(%Organization{} = org, %App{} = app) do
    %{context: %{organization: org, app: app}}
  end

  defp authenticate(conn) do
    with ["Bearer " <> auth_token] <- get_req_header(conn, "authorization"),
         {:ok, org} <- Auth.get_organization_by_app_token(auth_token) do
      {:ok, org, Auth.get_app_by_token(auth_token)}
    else
      [] ->
        {:error, :header_not_found}

      {:error, :unauthorized} ->
        {:error, :unauthorized}
    end
  end

  defp unauthorized_response(conn) do
    conn
    |> send_resp(401, "Unauthorized")
    |> halt()
  end
end
