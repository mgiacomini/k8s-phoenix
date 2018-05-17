use Mix.Config

# Configure your database
config :backoffice, Backoffice.Repo,
adapter: Ecto.Adapters.Postgres,
username: System.get_env("PG_USERNAME") || "postgres",
password: System.get_env("PG_PASSWORD") || "postgres",
database: "backoffice_dev",
hostname: System.get_env("PG_HOST") || "localhost",
pool_size: 10
