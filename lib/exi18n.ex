defmodule ExI18n do
  @doc "Default locale."
  def locale, do: Application.get_env(:exi18n, :default_locale)

  @doc "Path to directory that contains all files with translations."
  def path, do: Application.get_env(:exi18n, :path)

  @doc "Storage type used to store translations."
  def storage, do: Application.get_env(:exi18n, :storage)
end
