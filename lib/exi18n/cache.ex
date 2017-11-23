defmodule ExI18n.Cache do
  @moduledoc """
  Cache that manage loaded locales.
  """

  use GenServer

  @table :exi18n_locales

  @doc """
  Starts a cache server.
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Initialize cache table.
  """
  def init(:ok) do
    {:ok, :ets.new(@table, [:named_table, :protected])}
  end

  @doc """
  Handler for `:fetch` call.
  """
  def handle_call({:fetch, locale}, _from, state) do
    translations =
      case :ets.lookup(@table, locale) do
        [result | _] ->
          elem(result, 1)

        [] ->
          try do
            ExI18n.Loader.load(locale) |> cache_translations(locale)
          rescue
            e in ArgumentError -> {:error, e.message}
          end
      end

    {:reply, translations, state}
  end

  defp cache_translations(translations, locale) do
    :ets.insert(@table, {locale, translations})
    translations
  end

  @doc """
  Fetch translations for given locale.

  ## Parameters

    - `locale`: `String` with locale to fetch.

  ## Examples

      iex> ExI18n.Cache.fetch("en")
      %{"empty" => "empty", "hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}
  """
  @spec fetch(String.t()) :: Map.t()
  def fetch(locale) do
    GenServer.call(__MODULE__, {:fetch, locale})
  end
end
