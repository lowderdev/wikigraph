defmodule Wikigraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :wikigraph,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Wikigraph.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 0.14"},
      {:httpoison, "~> 1.6"},
      {:mox, "~> 0.5", only: :test}
    ]
  end
end
