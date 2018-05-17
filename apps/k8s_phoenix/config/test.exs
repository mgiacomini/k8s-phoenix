use Mix.Config

# Configure your database
config :k8s_phoenix, K8sPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "k8s_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
