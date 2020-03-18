defmodule ExI18n.Loader do
  @moduledoc """
  Loads translations.
  """

  @callback load(locale :: String.t(), options :: term()) ::
              {:ok, translations :: map()} | {:error, error :: term()}

  @doc "Loader type used to store translations."
  @spec loader_type :: atom()
  def loader_type, do: Application.get_env(:exi18n, :loader) || :yml

  @doc "Options for loader."
  @spec options() :: term()
  def options, do: Application.get_env(:exi18n, :loader_options) || %{}

  @doc """
  Loads translations for `locale`.

  It will use adapter based on `storage` set in configuration. See `get/1`

  ## Parameters

    - `locale`: `String` with name of locale/file.

  """
  @spec load(String.t()) :: {:ok, map()} | {:error, term()}
  def load(locale) do
    get(loader_type()).load(locale, options())
  end

  @doc """
  Returns loader module based on `type` that will load translation file.

  ## Parameters

    - `loader`: `Atom` with name of storage type or `Module`.

  ## Examples

      iex> ExI18n.Loader.get(:yml)
      ExI18n.Loader.YAML

  """
  @spec get(atom() | module()) :: module()
  def get(:yml), do: ExI18n.Loader.YAML
  def get(loader), do: loader
end
