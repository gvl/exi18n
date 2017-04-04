use Mix.Config

config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: true,
  path: "test/fixtures",
  # compile_prefix: "%{",
  # compile_suffix: "}",
  storage: :yml
