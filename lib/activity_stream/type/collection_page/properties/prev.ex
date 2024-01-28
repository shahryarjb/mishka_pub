defmodule ActivityStream.Type.CollectionPage.Properties.Prev do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#prev
  # In a paged Collection, identifies the previous page of items.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | href
  # ---------------------------------------------------------------------------------------
  # Domain:	CollectionPage
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Page 1 of Sally's blog posts",
  #   "type": "CollectionPage",
  #   "prev": "http://example.org/collection?page=1",
  #   "items": [
  #     "http://example.org/posts/1",
  #     "http://example.org/posts/2",
  #     "http://example.org/posts/3"
  #   ]
  # }
  # ----------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Page 1 of Sally's blog posts",
  #   "type": "CollectionPage",
  #   "prev": {
  #     "type": "Link",
  #     "name": "Previous Page",
  #     "href": "http://example.org/collection?page=1"
  #   },
  #   "items": [
  #     "http://example.org/posts/1",
  #     "http://example.org/posts/2",
  #     "http://example.org/posts/3"
  #   ]
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Link"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=360, min_len=3)"
    )

    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )
  end
end
