defmodule Api.Plugs.AuthenticationTest do
  use Api.ConnCase
  alias Api.Plugs.Authentication
  alias Backoffice.Auth

  test "returns unauthorized when authorization header is empty" do
    conn = Authentication.call(build_conn(), %{})

    assert conn.status == 401
  end

  test "returns unauthorized when authorization header is invalid" do
    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer xxxx")
      |> Authentication.call(%{})

    assert conn.status == 401
  end

  test "returns success when authorization header is valid" do
    fake_organization = %{name: "fake", subdomain: "fake"}
    {:ok, org} = Auth.create_organization(fake_organization)

    fake_app = %{
      app_id: "fakeapp",
      app_secret: "fakesecret",
      domain: "atelware.com",
      organization_id: org.id
    }

    {:ok, app} = Auth.create_app(fake_app)

    {:ok, authenticated_app} =
      Auth.authenticate_app(%{app_id: app.app_id, app_secret: app.app_secret})

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{authenticated_app.token}")
      |> Authentication.call(%{})

    assert conn.status == nil
  end
end
