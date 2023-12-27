defmodule ActivityStream.Type.Activity.Properties.Instrument do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#instrument
  # Identifies one or more objects used (or to be used) in the completion of an Activity.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain:	Activity
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Person"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
