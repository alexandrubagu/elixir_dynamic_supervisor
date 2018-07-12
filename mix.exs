defmodule WunderTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :wunder_test,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :nimble_csv],
      mod: {TestApp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_csv, "~> 0.4"},
      {:envelope, "~> 1.1"}
    ]
  end
end
