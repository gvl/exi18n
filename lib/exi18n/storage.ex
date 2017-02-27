defmodule ExI18n.Storage do
  def get(type) do
    case type do
      :yml -> ExI18n.Storage.YAML
    end
  end
end
