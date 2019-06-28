defmodule BusinessLogic.MixProject do
  use Mix.Project

  def project do
    [
      app: :business_logic,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BusinessLogic, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.0"},
      {:plug, "~> 1.8"},
      {:cowboy, "~> 2.5"},
      {:plug_cowboy, "~> 2.0"},
      {:httpoison, "~> 1.4"},
      # {:cors_plug, "~> 2.0"},
      { :elixir_uuid, "~> 1.2" }
    ]
  end
end
