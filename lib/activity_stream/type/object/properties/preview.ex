defmodule ActivityStream.Type.Object.Properties.Preview do
  use GuardedStruct
  alias ActivityStream.Type.Object.Properties.Url

  # URI: https://www.w3.org/ns/activitystreams#preview
  # Identifies an entity that provides a preview of this object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | duration | url --> href | mediaType
  # ---------------------------------------------------------------------------------------
  # Domain: Link | Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Video",
  #   "name": "Cool New Movie",
  #   "duration": "PT2H30M",
  #   "preview": {
  #     "type": "Video",
  #     "name": "Trailer",
  #     "duration": "PT1M",
  #     "url": {
  #       "href": "http://example.org/trailer.mkv",
  #       "mediaType": "video/mkv"
  #     }
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      default: "Video",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    # The value associated with "duration" is an ISO 8601 duration string.
    # Ex: "duration": "PT2H30M"
    field(:duration, String.t(),
      enforce: true,
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, max_len=10, custom=[MishkaPub.Helper.Extra, is_duration?])"
    )

    field(:url, struct(), structs: true, struct: Url, derive: "validate(list, not_empty)")
  end
end
