defmodule Chhota.MixProject do
  use Mix.Project

  def project do
    [
      app: :chhota,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Chhota.Application, []}
      # Elixir automatically infers your list of applications from your deps
      # (this was added in v1.4), if you set the key manually, you'll have to 
      # add all the applications your dependencies need. Read - 
      # http://blog.plataformatec.com.br/2016/07/understanding-deps-and-applications-in-your-mixfile/
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:airtable, "~> 0.4.0"},
      {:cachex, "~> 3.3"}
    ]
  end
end
