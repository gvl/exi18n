defmodule ExI18n.Storage do
  def load(locale) do
    get(ExI18n.storage()).load(locale)
  end
  def get(:yml), do: ExI18n.Storage.YAML
end
