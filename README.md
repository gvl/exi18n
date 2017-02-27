# ExI18n

[![hex.pm version](https://img.shields.io/hexpm/v/exi18n.svg)](https://hex.pm/packages/exi18n) [![Build Status](https://travis-ci.org/gvl/exi18n.svg?branch=master)](https://travis-ci.org/gvl/exi18n) [![Coverage Status](https://coveralls.io/repos/gvl/exi18n/badge.svg?branch=master)](https://coveralls.io/r/gvl/exi18n?branch=master) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/gvl/exi18n.svg)](https://beta.hexfaktor.org/github/gvl/exi18n)

**ExI18n** is key-based internationalization library for Elixir.

## Installation

Add `exi18n` to your list of dependencies and to `applications` in `mix.exs`:

```elixir
def deps do
  [
    {:exi18n, "~> 0.1.0"}
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
  path: "priv/locales",
  storage: :yml
```
  - `default_locale` - default locale in your application.
  - `path` - path to your translation files.
  - `storage` - storage type. Supported types: `:yml`

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
