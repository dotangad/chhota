defmodule Chhota.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = System.get_env("PORT", "4001") |> String.to_integer()

    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Chhota.Router, options: [port: port])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chhota.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
