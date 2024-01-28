defmodule ActivityStream.Type.Object.Properties.Image do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#image
  # Indicates an entity that describes an image for this object.
  # Unlike the icon property, there are no aspect ratio or display size limitations assumed.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | url --> href | mediaType
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Image",
  #   "name": "Cat Jumping on Wagon",
  #   "url": [
  #     {
  #       "type": "Link",
  #       "href": "http://example.org/image.jpeg",
  #       "mediaType": "image/jpeg"
  #     },
  #     {
  #       "type": "Link",
  #       "href": "http://example.org/image.png",
  #       "mediaType": "image/png"
  #     }
  #   ]
  # }
  guardedstruct do
    field(:type, String.t(),
      default: "Image",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=String::Image)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    sub_field(:url, struct(), enforce: true) do
      field(:type, String.t(),
        default: "Link",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=String::Link)"
      )

      field(:href, String.t(),
        enforce: true,
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
      )

      field(:mediaType, String.t(),
        enforce: true,
        derive:
          "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
      )
    end
  end
end
