defmodule Chhota.Router do
  @moduledoc """
  Router responsible for handling requests and redirecting to appropriate URL.
  """

  @base_website "https://angad.dev"

  use Plug.Router
  alias Chhota.Airtable

  plug(:match)
  plug(:dispatch)

  match _ do
    case Airtable.get(conn.request_path) do
      {:ok, url} ->
        conn
        |> redirect(url)

      {:not_found} ->
        conn
        |> redirect(@base_website, 404)

      {:error, err} ->
        conn
        |> send_resp(500, "Error: " <> err)

      _ ->
        conn
        |> send_resp(500, "An error occurred")
    end

    halt(conn)
  end

  defp redirect(conn, to), do: redirect(conn, to, 301)

  defp redirect(conn, to, status) when is_bitstring(to) do
    conn
    |> put_resp_header("Location", to)
    |> send_resp(status, "")
  end
end
