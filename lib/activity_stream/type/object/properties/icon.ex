defmodule ActivityStream.Type.Object.Properties.Icon do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#icon
  # Indicates an entity that describes an icon for this object.
  # The image should have an aspect ratio of one (horizontal) to one (vertical)
  # and should be suitable for presentation at a small size.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | summary | name | url | width | height
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A simple note",
  #   "type": "Note",
  #   "content": "This is all there is.",
  #   "icon": {
  #     "type": "Image",
  #     "name": "Note icon",
  #     "url": "http://example.org/note.png",
  #     "width": 16,
  #     "height": 16
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=String::Image)"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    field(:url, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:width, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    field(:height, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )
  end
end
