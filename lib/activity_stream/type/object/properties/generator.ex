defmodule ActivityStream.Type.Object.Properties.Generator do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#icon
  # Indicates an entity that describes an icon for this object.
  # The image should have an aspect ratio of one (horizontal) to one (vertical)
  # and should be suitable for presentation at a small size.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=150, min_len=3)"
    )
  end
end
