defmodule ActivityStream.Type.Collection.Properties.Last do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#last
  # In a paged Collection, indicates the furthest proceeding page of the collection.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | summary | href
  # ---------------------------------------------------------------------------------------
  # Domain:	Collection
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A collection",
  #   "type": "Collection",
  #   "totalItems": 3,
  #   "last": "http://example.org/collection?page=1"
  # }
  # -----------------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A collection",
  #   "type": "Collection",
  #   "totalItems": 5,
  #   "last": {
  #     "type": "Link",
  #     "summary": "Last Page",
  #     "href": "http://example.org/collection?page=1"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Link"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )
  end
end
