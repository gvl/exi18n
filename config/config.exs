use Mix.Config

config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: false,
  loader: :yml,
  loader_options: %{path: "test/fixtures"}
