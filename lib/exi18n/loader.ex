defmodule ExI18n.Loader do
  @moduledoc """
  Loads translations.
  """

  @doc """
  Loads translations for `locale`.

  It will use adapter based on `storage` set in configuration. See `get/1`

  ## Parameters

    - `locale`: `String` with name of locale/file.

  ## Examples

      iex> ExI18n.Loader.load("en")
      %{"hello" => "Hello world", "hello_2" => %{"world" => "test"},"hello_many" => ["Joe", "Mike"], "hello_name" => "Hello %{name}","incomplete" => %{"path" => %{"text" => "test"}}, "number" => 1}
  """
  @spec load(String.t) :: Map.t
  def load(locale) do
    get(ExI18n.storage()).load(locale)
  end

  @doc """
  Returns loader module based on `type` that will load translation file.

  ## Parameters

    - `type`: `Atom` with name of storage type.

  ## Examples

      iex> ExI18n.Loader.get(:yml)
      ExI18n.Loader.YAML
  """
  @spec get(Atom.t) :: Module.t
  def get(:yml), do: ExI18n.Loader.YAML
end
