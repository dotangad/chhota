defmodule Chhota.KV do
  @moduledoc """
  Talks to airtable and fetches required URL when given a key.
  """

  @airtable_api_key Application.get_env(:chhota, :airtable_api_key, "")
  @airtable_table_key Application.get_env(:chhota, :table_key, "")
  @airtable_table_name Application.get_env(:chhota, :table_name, "")

  # TODO: add cache

  def get(key) when is_binary(key) do
    response =
      Airtable.list(
        @airtable_api_key,
        @airtable_table_key,
        @airtable_table_name
      )

    case response do
      {:ok, records} ->
        url_from_record_list(records, key)

      {:error, err} ->
        handle_get_err(err)
    end
  end

  defp handle_get_err(err) do
    IO.inspect(err)

    {:error, :unknown}
  end

  defp url_from_record_list(list, key) do
    %Airtable.Result.List{offset: nil, records: records} = list

    case Enum.find(
           records,
           fn %Airtable.Result.Item{fields: %{"Short" => short}} ->
             short == key
           end
         ) do
      %Airtable.Result.Item{fields: %{"Long" => long}} ->
        {:ok, long}

      nil ->
        {:error, :not_found}

      _ ->
        {:error, :unknown}
    end
  end

  def get_old(key) when is_binary(key) do
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
