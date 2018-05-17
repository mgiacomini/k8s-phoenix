defmodule K8sPhoenix.Application do
  @moduledoc """
  The K8sPhoenix Application Service.

  The k8s_phoenix system business domain lives in this application.

  Exposes API to clients such as the `K8sPhoenixWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(K8sPhoenix.Repo, []),
    ], strategy: :one_for_one, name: K8sPhoenix.Supervisor)
  end
end
