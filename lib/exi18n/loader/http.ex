if Code.ensure_loaded?(Tesla) do
  defmodule ExI18n.Loader.HTTP do
    @moduledoc """
    Fetches translations from provided API.
    """
    use Tesla, only: ~w(get post)a, docs: false

    adapter fn(env) ->
      adapter = Map.get(ExI18n.Loader.options(), :adapter, Tesla.Adapter.Httpc)
      adapter_options = Map.get(ExI18n.Loader.options(), :adapter_options)
      adapter.call(env, adapter_options)
    end

    @doc """
    Fetches translations from url.

    ## Parameters

      - `locale`: `String` with name of locale.
      - `options`: `Map` with options for loader.
    """
    @spec load(String.t, Map.t) :: Map.t
    def load(locale, %{method: method} = options) do
      options
        |> Map.take([:url, :headers, :middlewares])
        |> client([])
        |> make_request(to_string(method), locale)
        |> resp_body(options)
    end

    defp resp_body(response, %{root: root} = _options) do
      response.body[to_string(root)]
    end
    defp resp_body(response, _), do: response.body

    defp make_request(client, method, locale) do
      case String.downcase(method) do
        "get" -> get(client, locale)
        "post" -> post(client, locale)
        _ -> raise ArgumentError, "Unsupported method #{method}"
      end
    end

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