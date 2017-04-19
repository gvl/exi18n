if Code.ensure_loaded?(Tesla) do
  defmodule ExI18n.Loader.HTTP do
    @moduledoc """
    Fetches translations from provided API.
    """
    use Tesla, only: ~w(get)a, docs: false

    adapter fn(env) ->
      options = ExI18n.Loader.options()
      adapter = Map.get(options, :adapter, Tesla.Adapter.Httpc)
      adapter_options = Map.get(options, :adapter_options)
      adapter.call(env, adapter_options)
    end

    @doc """
    Fetches translations from url.

    ## Parameters

      - `locale`: `String` with name of locale.
      - `options`: `Map` with options for loader.
    """
    @spec load(String.t, Map.t) :: Map.t
    def load(locale, options) do
      options
        |> Map.take([:url, :headers, :middlewares])
        |> client([])
        |> get(locale)
        |> resp_body(options)
    end

    defp resp_body(response, %{root: root} = _options) do
      response.body[to_string(root)]
    end
    defp resp_body(response, _), do: response.body

    defp client(%{url: url} = options, middlewares) do
      middlewares = [{Tesla.Middleware.BaseUrl, url} | middlewares]
      client(Map.delete(options, :url), middlewares)
    end
    defp client(%{headers: headers} = options, middlewares) do
      middlewares = [{Tesla.Middleware.Headers, headers} | middlewares]
      client(Map.delete(options, :headers), middlewares)
    end
    defp client(%{middlewares: custom_middlewares} = options, middlewares) do
      middlewares = middlewares ++ List.wrap(custom_middlewares)
      client(Map.delete(options, :middlewares), middlewares)
    end
    defp client(%{}, middlewares), do: Tesla.build_client(middlewares)
  end
end