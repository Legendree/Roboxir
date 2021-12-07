defmodule Roboxir.MixProject do
  use Mix.Project

  def project do
    [
      app: :roboxir,
      version: "0.1.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Roboxir",
      source_url: "https://github.com/Legendree/Roboxir",
      description: description(),
      package: package(),
      docs: [
        main: Roboxir,
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :ssl],
      mod: {Roboxir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end

  defp description() do
    "0 dependencies, straightforward Robots.txt parser."
  end

  defp package() do
    [licenses: ["Apache-2.0"], links: %{"GitHub" => "https://github.com/Legendree/Roboxir"}]
  end
end
