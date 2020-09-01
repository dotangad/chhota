defmodule Chhota.Airtable do
  @moduledoc """
  Talks to airtable and fetches required URL when given a key.
  """

  def get(key) when is_binary(key) do
    case Enum.random(0..10) do
      r when r < 6 -> {:ok, "https://exunclan.com"}
      r when r < 9 -> {:not_found}
      _default -> {:error, "Internal Server Error"}
    end
  end

  def get do
    {:error, "Invalid key"}
  end
end
