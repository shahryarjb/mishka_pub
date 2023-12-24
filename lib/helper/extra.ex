defmodule MishkaPub.Helper.Extra do
  # The value associated with "duration" is an ISO 8601 duration string.
  # It forces to put all element of this ISO
  # Ex: "duration": "PT2H30M"
  def is_duration?(value) when is_binary(value) do
    ~r"^PT(\d+H)?(\d+M)?(\d+S)?$"
    |> Regex.match?(value)
  end

  def is_duration?(_value), do: false
end
