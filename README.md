# ExI18n

[![hex.pm version](https://img.shields.io/hexpm/v/exi18n.svg)](https://hex.pm/packages/exi18n) [![Build Status](https://travis-ci.org/gvl/exi18n.svg?branch=master)](https://travis-ci.org/gvl/exi18n) [![Coverage Status](https://coveralls.io/repos/gvl/exi18n/badge.svg?branch=master)](https://coveralls.io/r/gvl/exi18n?branch=master) [![Inline docs](http://inch-ci.org/github/gvl/exi18n.svg?branch=master&style=shields)](http://inch-ci.org/github/gvl/exi18n) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/gvl/exi18n.svg)](https://beta.hexfaktor.org/github/gvl/exi18n)

**ExI18n** is key-based internationalization library for Elixir.

## Installation

Add `exi18n` to your list of dependencies and to `applications` in `mix.exs`:

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.6.0"},
  ]
end

def application do
  [applications: [:exi18n]]
end
```

## Configuration

Add configuration to your `config/config.exs`:

```elixir
# config.exs

config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: false,
  loader: :yml,
  loader_options: %{path: "priv/locales"}
  var_prefix: "%{",
  var_suffix: "}",
```

### Configuration parameters

| Option | Description | Default |
| :-- | :-- | :--: |
| default_locale | Default locale in your application. | `"en"` |
| locales | Supported locales. | `["en"]` |
| fallback | Fallback to default locale if translation empty. | `false` |
| loader | Translation loader. Supported types: `:yml`, `:http`, `MyApp.Loader`. | `:yml` |
| loader_options | Translation loader options. | `%{}` |
| var_prefix | Prefix for values in translations. | `"%{"` |
| var_suffix | Suffix for values in translations. | `"}"` |

### Loaders

#### YAML

This loader will use yaml files from `path` to load translations.

##### Module

`ExI18n.Loader.YAML`

##### Dependencies

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.6.0"},
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

##### Configuration

| Option | Required | Description |
| :-- | :--: | :-- |
| path | **Yes** | Path to locale files. |

```elixir
# config.exs

config :exi18n,
  loader: :yml,
  loader_options: %{
    path: "priv/locales"
  }
```

#### HTTP

This loader will call API to fetch translations.

##### Module

`ExI18n.Loader.HTTP`

##### Dependencies

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.6.0"},
    {:tesla, "~> 0.6.0"},
    {:poison, ">= 1.0.0"}, # for JSON middleware
  ]
end

def application do
  [applications: [
    :exi18n,
  ]]
end
```

##### Configuration

| Option | Required | Description |
| :-- | :--: | :-- |
| url | **Yes** | Translations API endpoint. |
| adapter | No | Adapter for Tesla. Default: `:httpc`. [Tesla Adapters](https://github.com/teamon/tesla#adapters-1) |
| adapter_options | No | Options for adapter. |
| headers | No | Headers passed with request to API. |
| middlewares | No | List of middlewares you want to use. [Tesla middlewares](https://github.com/teamon/tesla#middleware) |
| root | No | Root key in response that contians translations. |

```elixir
# config.exs

config :exi18n,
  loader: :http,
  loader_options: %{
    url: "https://www.example.com/translations",
    adapter: Tesla.Adapter.Httpc,
    adapter_options: nil,
    headers: %{"Authorization" => "Bearer <token>"},
    middlewares: [
      {Tesla.Middleware.JSON, nil},
      {MyApp.Middleware, %{option: "option"}},
    ],
    root: false
  }
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

##### Dependencies

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.6.0"},
  ]
end

def application do
  [applications: [
    :exi18n,
  ]]
end
```

##### Configuration

```elixir
# config.exs

config :exi18n,
  loader: MyApp.Loader,
  loader_options: %{my_config: "value"}
```

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
