defmodule ExI18n.Loader.HTTPTest do
  use ExUnit.Case
  doctest ExI18n.Loader.HTTP

  defmodule MockAdapter do
    def call(env, _) do
      case env.url do
        "http://localhost/en" ->
          %{env | status: 200, body: body()}

        "http://localhost/de" ->
          %{env | status: 200, body: %{"root" => body()}}

        "http://localhost/fr" ->
          if env.headers["authorization"] != "token" do
            raise ArgumentError, "invalid token"
          end

          unless env.query[:test] do
            raise ArgumentError, "no query"
          end

          %{env | status: 200, body: body()}

        _ ->
          %{env | status: 200, body: %{}}
      end
    end

    def body, do: %{"test" => "test"}
  end

  setup do
    url = "http://localhost"
    options = %{url: url, adapter: MockAdapter}
    options2 = %{url: url, adapter: MockAdapter, root: "root"}

    options3 = %{
      url: url,
      adapter: MockAdapter,
      headers: %{"Authorization" => "token"},
      middlewares: [{Tesla.Middleware.Query, %{test: true}}]
    }

    Application.put_env(:exi18n, :loader, :http)
    Application.put_env(:exi18n, :loader_options, options)

    on_exit(fn ->
      Application.put_env(:exi18n, :loader, :yml)

      Application.put_env(:exi18n, :loader_options, %{path: "test/fixtures"})
    end)

    {:ok, %{options: options, options2: options2, options3: options3, body: MockAdapter.body()}}
  end

  test "load/2 returns loaded translations from API", context do
    assert ExI18n.Loader.HTTP.load("en", context.options) == context.body
    assert ExI18n.Loader.HTTP.load("de", context.options2) == context.body
    assert ExI18n.Loader.HTTP.load("fr", context.options3) == context.body

    assert_raise ArgumentError, "invalid token", fn ->
      ExI18n.Loader.HTTP.load("fr", context.options)
    end

    assert_raise ArgumentError, "no query", fn ->
      options = Map.put(context.options, :headers, %{"Authorization" => "token"})
      ExI18n.Loader.HTTP.load("fr", options)
    end
  end
end
