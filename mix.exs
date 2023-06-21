defmodule MishkaPub.MixProject do
  use Mix.Project

  def project do
    [
      app: :mishka_pub,
      version: "0.0.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MishkaPub.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.14"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false}
    ]
  end
end
