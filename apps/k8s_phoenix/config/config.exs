use Mix.Config

config :k8s_phoenix, ecto_repos: [K8sPhoenix.Repo]

import_config "#{Mix.env}.exs"
