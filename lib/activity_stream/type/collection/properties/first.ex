defmodule ActivityStream.Type.Collection.Properties.First do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#first
  # In a paged Collection, indicates the furthest preceeding page of items in the collection.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | summary | href
  # ---------------------------------------------------------------------------------------
  # Domain:	Collection
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally's blog posts",
  #   "type": "Collection",
  #   "totalItems": 3,
  #   "first": "http://example.org/collection?page=0"
  # }
  # -----------------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally's blog posts",
  #   "type": "Collection",
  #   "totalItems": 3,
  #   "first": {
  #     "type": "Link",
  #     "summary": "First Page",
  #     "href": "http://example.org/collection?page=0"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Link"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=360, min_len=3)"
    )

    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )
  end
end
