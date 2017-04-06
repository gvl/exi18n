# ExI18n

[![hex.pm version](https://img.shields.io/hexpm/v/exi18n.svg)](https://hex.pm/packages/exi18n) [![Build Status](https://travis-ci.org/gvl/exi18n.svg?branch=master)](https://travis-ci.org/gvl/exi18n) [![Coverage Status](https://coveralls.io/repos/gvl/exi18n/badge.svg?branch=master)](https://coveralls.io/r/gvl/exi18n?branch=master) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/gvl/exi18n.svg)](https://beta.hexfaktor.org/github/gvl/exi18n)

**ExI18n** is key-based internationalization library for Elixir.

## Installation

Add `exi18n` to your list of dependencies and to `applications` in `mix.exs`:

```elixir
def deps do
  [
    {:exi18n, "~> 0.5.2"}
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
  loader: :yml,
  path: "priv/locales",
  compile_prefix: "%{",
  compile_suffix: "}",
```

Configuration parameters:
- `default_locale` - default locale in your application. Default: `"en"`
- `locales` - supported locales. Default: `["en"]`
- `fallback` - fallback to default locale if translation empty. Default: `false`
- `path` - path to your translation files. Default: `"priv/locales"`
- `compile_prefix` - prefix for values in translations. Default: `"%{"`
- `compile_suffix` - suffix for values in translations. Default: `"}"`
- `storage` - storage type. Supported types: `:yml`, Default: `:yml`

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
