defmodule ExI18n do
  @moduledoc """
  ExI18n - key-based internationalization library.
  """

  @doc false
  def start(_type, _args), do: ExI18n.Supervisor.start_link()

  @doc "Default locale set in configuration."
  def locale, do: Application.get_env(:exi18n, :default_locale) || "en"

  @doc "Supported locales."
  def locales, do: Application.get_env(:exi18n, :locales) || ~w(en)

  @doc "Flag to determine if fallback to default locale."
  def fallback, do: Application.get_env(:exi18n, :fallback) || false

  @doc "Path to directory that contains all files with translations."
  def path, do: Application.get_env(:exi18n, :path) || "priv/locales"

  @doc "Storage type used to store translations."
  def storage, do: Application.get_env(:exi18n, :storage) || :yml

  @doc """
  Search for translation in given `locale` based on provided `key`.

  ## Parameters

    - `locale`: `String` with name of locale.
    - `key`: `String` with path to translation.
    - `values`: `Map` with values that will be interpolated.

  ## Examples

      iex> ExI18n.t("en", "hello")
      "Hello world"

      iex> ExI18n.t("en", "hello_name", name: "Joe")
      "Hello Joe"

      iex> ExI18n.t("en", "invalid")
      ** (ArgumentError) Missing translation for key: invalid

      iex> ExI18n.t("en", "incomplete.path")
      ** (ArgumentError) incomplete.path is incomplete path to translation.

      iex> ExI18n.t("en", "hello_name", name: %{"1" => "2"})
      ** (Protocol.UndefinedError) protocol String.Chars not implemented for %{"1" => "2"}
  """
  @spec t(String.t, String.t, Map.t) :: String.t
  def t(locale, key, values \\ %{}) do
    translation = get_translation(locale, key)
    if fallback() and translation == "" do
      get_translation(locale(), key) |> validate(key, values)
    else
      validate(translation, key, values)
    end
  end

  defp validate(text, _, _) when is_number(text), do: text
  defp validate(text, _, values) when is_bitstring(text) or is_list(text) do
    ExI18n.Compiler.compile(text, values)
  end
  defp validate(text, key, _) when is_nil(text) do
    raise ArgumentError, "Missing translation for key: #{key}"
  end
  defp validate(_, key, _) do
    raise ArgumentError, "#{key} is incomplete path to translation."
  end

  defp get_translation(locale, key) do
    parse_locale(locale)
    |> ExI18n.Cache.fetch()
    |> get_in(extract_keys(key))
  end

  defp extract_keys(key), do: String.split(key, ".")

  defp parse_locale(loc) do
    if loc in locales(), do: loc, else: locale()
  end
end
