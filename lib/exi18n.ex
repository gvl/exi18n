defmodule ExI18n do
  @moduledoc """
  ExI18n - key-based internationalization library.
  """

  @doc "Default locale set in configuration."
  def locale, do: Application.get_env(:exi18n, :default_locale)

  @doc "Path to directory that contains all files with translations."
  def path, do: Application.get_env(:exi18n, :path)

  @doc "Storage type used to store translations."
  def storage, do: Application.get_env(:exi18n, :storage)

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
    translation = load_locales(locale) |> get_in(extract_keys(key))
    cond do
      is_bitstring(translation) || is_list(translation) ->
        ExI18n.Compiler.compile(translation, values)
      is_number(translation) -> translation
      is_nil(translation) -> raise ArgumentError, "Missing translation for key: #{key}"
      true -> raise ArgumentError, "#{key} is incomplete path to translation."
    end
  end

  defp extract_keys(key), do: String.split(key, ".")

  defp load_locales(locale) do
    init_cache()
    case :ets.lookup(:exi18n_locales, locale) do
     [result|_] -> elem(result, 1)
     [] ->
       translations = ExI18n.Loader.load(locale)
       :ets.insert(:exi18n_locales, {locale, translations})
       translations
    end
  end

  defp init_cache do
    if :ets.info(:exi18n_locales) == :undefined do
      :ets.new(:exi18n_locales, [:named_table])
    end
  end
end
