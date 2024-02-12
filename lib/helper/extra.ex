defmodule MishkaPub.Helper.Extra do
  # The value associated with "duration" is an ISO 8601 duration string.
  # It forces to put all element of this ISO
  # Ex: "duration": "PT2H30M"
  def is_duration?(value) when is_binary(value) do
    ~r"^PT(\d+H)?(\d+M)?(\d+S)?$"
    |> Regex.match?(value)
  end

  def is_duration?(_value), do: false

  def validate_username(:preferredUsername, username) when is_binary(username) do
    regex = ~r/^[a-zA-Z0-9_]+$/

    if Regex.match?(regex, username),
      do: {:ok, :preferredUsername, username},
      else: validate_username(:preferredUsername, :error)
  end

  def validate_username(:preferredUsername, _username),
    do:
      {:error, :preferredUsername,
       "Invalid username. Username can only contain English letters (a-z), numbers (0-9), and underscores (_)"}
end
