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

  ## Returns `String`.
  """
  @spec t(String.t, String.t, Map.t) :: String.t
  def t(locale, key, values \\ %{}) do
    translation = load_locales(locale) |> get_in(extract_keys(key))
    cond do
      is_bitstring(translation) -> insert_values(translation, values)
      is_number(translation) || is_list(translation) -> translation
      is_nil(translation) -> raise ArgumentError, "Missing translation for key: #{key}"
      true -> raise ArgumentError, "#{key} is incomplete path to translation."
    end
  end

  defp insert_values(text, %{}), do: text
  defp insert_values(text, values) do
    Enum.reduce values, text, fn({key, value}, result) ->
      String.replace(result, "%{#{key}}", to_string(value))
    end
  end

  defp extract_keys(key), do: String.split(key, ".")

  defp load_locales(locale) do
    init_cache()
    case :ets.lookup(:locales, locale) do
     [result|_] -> elem(result, 1)
     [] ->
       translations = ExI18n.Storage.load(locale)
       :ets.insert(:locales, {locale, translations})
       translations
    end
  end

  defp init_cache do
    try do
      :ets.new(:locales, [:named_table])
    rescue
      _ -> nil
    end
  end
end
