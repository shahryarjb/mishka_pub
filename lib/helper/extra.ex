defmodule MishkaPub.Helper.Extra do
  def is_duration?(value) when is_binary(value) do
    ~r"^PT(\d+H)?(\d+M)?(\d+S)?$"
    |> Regex.match?(value)
  end

  def is_duration?(_value), do: false

  def test_function do
    Enum.map([1, 2, 3], fn x -> IO.inspect(x) end)
  end

  # def get_direction(property, value, method) do
  #   case method do
  #     :first_strong_directional_char ->
  #       get_direction_by_first_strong_directional_char(value)

  #     :bidi_control_char ->
  #       get_direction_by_bidi_control_char(value)

  #     :html_markup ->
  #       get_direction_by_html_markup(property, value)

  #     _ ->
  #       "Unknown"
  #   end
  # end

  # defp get_direction_by_first_strong_directional_char(value) do
  #   codepoints = String.codepoints(value)
  #   first_directional_char = Enum.find(codepoints, &is_strong_directional_char/1)

  #   case :unicode.char_direction(first_directional_char) do
  #     :unicode.left_to_right() -> "Left-to-Right"
  #     :unicode.right_to_left() -> "Right-to-Left"
  #     _ -> "Unknown"
  #   end
  # end

  # defp is_strong_directional_char(char) do
  #   :unicode.char_direction(char) != :unicode.dummy_direction()
  # end

  # defp get_direction_by_bidi_control_char(value) do
  #   case value do
  #     _ when String.starts_with?(value, "\u200F") -> "Right-to-Left"
  #     _ when String.starts_with?(value, "\u200E") -> "Left-to-Right"
  #     _ -> "Unknown"
  #   end
  # end

  # defp get_direction_by_html_markup(property, value) do
  #   case property do
  #     :name ->
  #       get_direction_by_first_strong_directional_char(strip_html_tags(value))

  #     :summary ->
  #       get_direction_by_first_strong_directional_char(strip_html_tags(value))

  #     _ ->
  #       "Unknown"
  #   end
  # end

  # defp strip_html_tags(value) do
  #   Regex.replace(value, ~r/<[^>]*>/, "")
  # end
end

# مثال استفاده
# IO.puts(MishkaPub.Helper.Extra.get_direction(:name, "פעילות הבינאום, W3C", :first_strong_directional_char)) # نتیجه: "Right-to-Left"
# IO.puts(MishkaPub.Helper.Extra.get_direction(:name, "The document was titled, '\u2067פעילות הבינאום, W3C\u2069'", :first_strong_directional_char)) # نتیجه: "Left-to-Right"
# IO.puts(MishkaPub.Helper.Extra.get_direction(:name, "\u200FHTML היא שפת סימון", :bidi_control_char)) # نتیجه: "Right-to-Left"
# IO.puts(MishkaPub.Helper.Extra.get_direction(:name, "\u200E'سلام' is hello in Persian.", :bidi_control_char)) # نتیجه: "Left-to-Right"
# IO.puts(MishkaPub.Helper.Extra.get_direction(:summary, "<p dir=\"rtl\">HTML היא שפת סימון</p>", :html_markup)) # ن
