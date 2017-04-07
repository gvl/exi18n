defmodule ExI18n.Loader.HTTPTest do
  use ExUnit.Case
  doctest ExI18n.Loader.HTTP

  defmodule MockAdapter do
    def call(env, _) do
      case env.url do
        "http://localhost/en" -> %{env | status: 200, body: en_body()}
        "http://localhost/de" -> %{env | status: 200, body: de_body()}
        _ -> %{env | status: 200, body: %{}}
      end
    end

    def en_body, do: %{"test" => "test"}
    def de_body, do: %{"test" => ""}
  end

  setup do
    options = %{url: "http://localhost", method: "GET", adapter: MockAdapter}
    Application.put_env(:exi18n, :loader, :http)
    Application.put_env(:exi18n, :loader_options, options)

    on_exit fn ->
      Application.put_env(:exi18n, :loader, :yml)
      Application.put_env(:exi18n, :loader_options, %{path: "test/fixtures"})
    end

    {:ok, %{options: options, en_body: MockAdapter.en_body(),
            de_body: MockAdapter.de_body()}}
  end

  test "load/2 returns loaded translations from API", context do
    assert ExI18n.Loader.HTTP.load("en", context.options) == context.en_body
    assert ExI18n.Loader.HTTP.load("de", context.options) == context.de_body

    Application.put_env(:exi18n, :loader, :http)
    Application.put_env(:exi18n, :loader_options, context.options)
  end

  test "load/2 raises error on unsupported method", context do
    assert_raise ArgumentError, "Unsupported method PUT", fn ->
      ExI18n.Loader.HTTP.load("en", %{context.options | method: "PUT"})
    end
  end
end
