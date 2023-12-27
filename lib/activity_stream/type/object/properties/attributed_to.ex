defmodule ActivityStream.Type.Object.Properties.AttributedTo do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#attributedTo
  # Identifies one or more entities to which this object is attributed.
  # The attributed entities might not be Actors. For instance, an object might
  # be attributed to the completion of another activity.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | String(url)
  # ---------------------------------------------------------------------------------------
  # Domain: Link | Object
  guardedstruct do
    field(:type, String.t(),
      default: "Person",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
