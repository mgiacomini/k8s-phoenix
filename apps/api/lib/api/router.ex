defmodule Api.Router do
  use Api, :router
  alias Api.Schema

  pipeline :api do
    plug(:accepts, ["json"])

    plug(
      Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Poison
    )
  end

  pipeline :graphiql do
    plug(
      Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Poison
    )
  end

  pipeline :graphql do
    plug(Absinthe.Plug, schema: Api.Schema)
  end

  pipeline :auth do
    plug(Api.Plugs.Authentication)
  end

  scope "/" do
    pipe_through([:graphiql, :auth, :graphql])

    forward("/", Absinthe.Plug, schema: Schema)
  end

  scope "/workspace" do
    pipe_through(:graphiql)

    forward("/", Absinthe.Plug.GraphiQL, schema: Schema)
  end

  scope "/apps" do
    pipe_through([:api])

    post("/auth", Api.AppController, :authenticate)
  end
end
