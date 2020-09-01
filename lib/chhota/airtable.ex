defmodule Chhota.Airtable do
  @moduledoc """
  Talks to airtable and fetches required URL when given a key.
  """

  def get(key) when is_binary(key) do
    {:ok, "https://angad.dev"}
  end

  def get do
    {:error, :no_arg}
  end
end
