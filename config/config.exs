use Mix.Config

config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: false,
  path: "test/fixtures",
  loader: :yml
