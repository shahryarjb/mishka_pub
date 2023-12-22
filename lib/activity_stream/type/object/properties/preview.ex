defmodule ActivityStream.Type.Object.Properties.Preview do
  use GuardedStruct
  alias ActivityStream.Type.Object.Properties.Url

  guardedstruct do
    field(:type, String.t(),
      default: "Video",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:name, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

    # The value associated with "duration" is an ISO 8601 duration string.
    # Ex: "duration": "PT2H30M"
    field(:duration, String.t(),
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, custom=[MishkaPub.Helper.Extra, is_duration?])"
    )

    field(:url, struct(), structs: true, struct: Url)
  end
end
