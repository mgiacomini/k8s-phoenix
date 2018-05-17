defmodule Api.AppControllerTest do
  use Api.ConnCase

  alias Backoffice.Auth

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, org} = Auth.create_organization(%{name: "fake", subdomain: "fake"})

    {:ok, app} =
      %{
        app_id: "fakeapp",
        app_secret: "fakesecret",
        domain: "atelware.com",
        organization_id: org.id
      }
      |> Auth.create_app()

    {:ok, authenticated_app} =
      %{app_id: app.app_id, app_secret: app.app_secret}
      |> Auth.authenticate_app()

    auth_conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{authenticated_app.token}")

    {:ok, conn: auth_conn}
  end

  describe "authenticate app" do
    test "renders application token when credentials are valid", %{conn: conn} do
      conn =
        post(conn, app_path(conn, :authenticate), %{
          "app_id" => "fakeapp",
          "app_secret" => "fakesecret"
        })

      assert %{"token" => _token} = json_response(conn, 200)["data"]
    end

    test "renders unauthorized errors when credentials are invalid", %{conn: conn} do
      conn = post(conn, attachment_path(conn, :create), attachment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
