# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :k8s_phoenix_web,
  namespace: Web,
  ecto_repos: [Backoffice.Repo]

# Configures the endpoint
config :k8s_phoenix_web, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cG2oyBrlfXc/egp8926gph1PASxB9E+2EycX62EkAC9U58rpsW2iOKH5JZaQcDoE",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :web, :generators,
  context_app: :backoffice

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
