defmodule Chhota.Router do
  @moduledoc """
  Router responsible for handling requests and redirecting to appropriate URL.
  """

  @base_website Application.get_env(:chhota, :base_website, "https://github.com/dotangad")
  @github_username Application.get_env(:chhota, :github_username, "dotangad")

  use Plug.Router
  alias Chhota.KV

  plug(:match)
  plug(:dispatch)

  get "/gh/:repo" do
    conn
    |> redirect("https:/github.com/" <> @github_username <> "/" <> repo)
    |> halt
  end

  match _ do
    case KV.get(conn.request_path) do
      {:ok, url} ->
        conn
        |> redirect(url)
        |> halt

      {:error, :not_found} ->
        conn
        |> redirect(@base_website)
        |> halt

      {:error, :unknown} ->
        conn
        |> send_resp(500, "An error occurred")
        |> halt

      _ ->
        conn
        |> send_resp(500, "An error occurred")
        |> halt
    end
  end

  defp redirect(conn, to), do: redirect(conn, to, 301)

  defp redirect(conn, to, status) when is_bitstring(to) do
    conn
    |> put_resp_header("Location", to)
    |> send_resp(status, "")
  end
end
