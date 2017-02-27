defmodule ExI18n.Storage do
  @moduledoc """
  Loads translations.
  """

  @doc """
  Loads translations for `locale`.

  It will use adapter based on `storage` set in configuration. See `get/1`

  ## Parameters

    - `locale`: `String` with name of locale/file.

  ## Returns `Map`.
  """
  @spec load(String.t) :: Map.t
  def load(locale) do
    get(ExI18n.storage()).load(locale)
  end

  @doc """
  Returns storage module based on `type` that will load translation file.

  ## Parameters

    - `type`: `Atom` with name of storage type.

  ## Returns `Module`.
  """
  @spec get(Atom.t) :: Module.t
  def get(:yml), do: ExI18n.Storage.YAML
end
