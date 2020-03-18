defmodule ExI18n.Cache do
  @moduledoc """
  Cache that manage loaded locales.
  """

  use GenServer

  @table :exi18n_locales

  @doc false
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc false
  def init(:ok) do
    {:ok, :ets.new(@table, [:named_table, :protected])}
  end

  @doc false
  def handle_call({:fetch, locale}, _from, state) do
    translations = get_translations(locale)
    {:reply, translations, state}
  end

  defp get_translations(locale) do
    case :ets.lookup(@table, locale) do
      [{_, translations} | _] -> translations
      [] -> locale |> ExI18n.Loader.load() |> cache_translations(locale)
    end
  end

  defp cache_translations({:ok, translations}, locale) do
    :ets.insert(@table, {locale, translations})
    translations
  end

  defp cache_translations({:error, error}, locale) do
    {:error, {locale, error}}
  end

  @doc """
  Fetch translations for given locale.

  ## Parameters

    - `locale`: `String` with locale to fetch.

  ## Examples

      iex> ExI18n.Cache.fetch("en")
      %{"empty" => "empty", "hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}

  """
  @spec fetch(String.t()) :: map() | none
  def fetch(locale) do
    case GenServer.call(__MODULE__, {:fetch, locale}) do
      {:error, {locale, error}} ->
        raise ArgumentError,
              inspect("""
              Locale: #{locale}
              Error: #{inspect(error)}
              """)

      translations ->
        translations
    end
  end
end
