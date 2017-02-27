# ExI18n

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
  path: "test/fixtures",
  storage: :yml
```
  - `default_locale` - default locale in your application.
  - `path` - path to your translation files.
  - `storage` - storage type. Supported types: `:yml`

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
