defmodule ExI18n.Mixfile do
  use Mix.Project

  def project do
    [app: :exi18n,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     source_url: "https://github.com/gvl/exi18n",
     homepage_url: "https://github.com/gvl/exi18n",
     docs: [main: "ExI18n", extras: ["README.md"]],
    ]
  end

  def application do
    [applications: [:yaml_elixir]]
  end

  defp deps do
    [
      {:yaml_elixir, ">= 1.3.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
