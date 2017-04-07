defmodule ExI18n.Mixfile do
  use Mix.Project

  def project do
    [app: :exi18n,
     version: "0.6.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.travis": :test],
     source_url: "https://github.com/gvl/exi18n",
     homepage_url: "https://github.com/gvl/exi18n",
     description: "ExI18n - key-based internationalization library.",
     docs: [main: "ExI18n", extras: ["README.md"]],
     package: package()
    ]
  end

  def application do
    [
      mod: {ExI18n, []}
    ]
  end

  defp deps do
    [
      {:yaml_elixir, "~> 1.3.0", optional: true},
      {:tesla, ">= 0.6.0", optional: true},
      {:poison, ">= 1.0.0", optional: true},
      {:ex_doc, "~> 0.15.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.6.3", only: :test}
    ]
  end

  defp package do
    [files: ["lib", "config", "mix.exs", "README.md"],
     maintainers: ["Igor Dominiak"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/gvl/exi18n"}]
  end
end
