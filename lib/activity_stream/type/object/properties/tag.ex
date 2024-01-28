defmodule ActivityStream.Type.Object.Properties.Tag do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#tag
  # One or more "tags" that have been associated with an objects. A tag can be any kind of Object.
  # The key difference between attachment and tag is that the former implies association by inclusion,
  # while the latter implies associated by reference.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | id | name
  # ---------------------------------------------------------------------------------------
  # Domain:	Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Image",
  #   "summary": "Picture of Sally",
  #   "url": "http://example.org/sally.jpg",
  #   "tag": [
  #     {
  #       "type": "Person",
  #       "id": "http://sally.example.org",
  #       "name": "Sally"
  #     }
  #   ]
  # }
  guardedstruct do
    field(:type, String.t(),
      default: "Person",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:id, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
