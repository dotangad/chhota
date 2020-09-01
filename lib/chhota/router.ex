defmodule Chhota.Router do
  @moduledoc """
  Router responsible for handling requests and redirecting to appropriate URL.
  """

  use Plug.Router
  alias Chhota.Airtable

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello, world!")
  end
end
