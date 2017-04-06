# ExI18n

[![hex.pm version](https://img.shields.io/hexpm/v/exi18n.svg)](https://hex.pm/packages/exi18n) [![Build Status](https://travis-ci.org/gvl/exi18n.svg?branch=master)](https://travis-ci.org/gvl/exi18n) [![Coverage Status](https://coveralls.io/repos/gvl/exi18n/badge.svg?branch=master)](https://coveralls.io/r/gvl/exi18n?branch=master) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/gvl/exi18n.svg)](https://beta.hexfaktor.org/github/gvl/exi18n)

**ExI18n** is key-based internationalization library for Elixir.

## Installation

Add `exi18n` to your list of dependencies and to `applications` in `mix.exs`:

```elixir
def deps do
  [
    {:exi18n, "~> 0.5.2"},
  ]
end

def application do
  [applications: [:exi18n]]
end
```

## Configuration

Add configuration to your `config/config.exs`:

```elixir
config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: false,
  loader: :yml,
  path: "priv/locales",
  var_prefix: "%{",
  var_suffix: "}",
```

### Configuration parameters

| Option | Description | Default |
| :-- | :-- | :-- |
| default_locale | Default locale in your application. | `"en"` |
| locales | Supported locales. | `["en"]` |
| fallback | Fallback to default locale if translation empty. | `false` |
| path | Path to your translation files. | `"priv/locales"` |
| var_prefix | Prefix for values in translations. | `"%{"` |
| var_suffix | Suffix for values in translations. | `"}"` |
| loader | Translation loader. Supported types: `:yml`, `MyApp.Loader`. | `:yml` |
| loader_options | Translation loader options. | `%{}` |

### Loaders

#### YAML

This loader will use yaml files from `path` to load translations.

##### Module

`ExI18n.Loader.YAML`

##### Configuration

```elixir
config :exi18n,
  loader: :yml,
  loader_options: %{path: "priv/locales"}
```

```elixir
def deps do
  [
    {:exi18n, "~> 0.5.2"},
    {:yaml_elixir, "~> 1.3.0"},
  ]
end

def application do
  [applications: [
    :exi18n,
    :yaml_elixir,
  ]]
end
```

#### Custom

##### Module

`MyApp.Loader`

Make sure that your custom loader has `load/2` function that accepts `locale` and `options` as parameters and returns `Map` with translations.

Example:

```elixir
defmodule MyApp.Loader do
  def load(locale, _options) do
    %{
      "en" => %{...},
      "de" => %{...}
    }[locale]
  end
end
```

##### Configuration

```elixir
config :exi18n,
  loader: MyApp.Loader,
  loader_options: %{my_config: "value"}
```

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
