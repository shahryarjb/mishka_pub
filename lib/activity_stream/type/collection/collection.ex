defmodule MishkaPub.ActivityStream.Type.Collection do
  use GuardedStruct
  alias ActivityStream.Type.Collection.Properties

  # URI: https://www.w3.org/ns/activitystreams#Collection
  # A Collection is a subtype of Object that represents ordered or unordered sets of Object or Link instances.
  # Refer to the Activity Streams 2.0 Core specification for a complete description of the Collection type.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # Inherits all properties from Object.
  # context | type | summary | items | totalItems | current | first | last
  # ---------------------------------------------------------------------------------------
  # Extends:	Object
  guardedstruct do
    # URI: https://www.w3.org/ns/activitystreams#context
    # Identifies the context within which the object exists or an activity was performed.
    # The notion of "context" used is intentionally vague. The intended function is to serve
    # as a means of grouping objects and activities that share a common originating context or purpose.
    # An example could be all activities relating to a common project or event.
    # Domain: Object
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    # URI: @type
    # Identifies the Object or Link type. Multiple values may be specified.
    # Domain: Object | Link
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Collection"
    )

    # URI: https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # URI: https://www.w3.org/ns/activitystreams#totalItems
    # A non-negative integer specifying the total number of objects contained by the logical
    # view of the collection. This number might not reflect the actual number
    # of items serialized within the Collection object instance.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's notes",
    #   "type": "Collection",
    #   "totalItems": 2,
    #   "items": [
    #     {
    #       "type": "Note",
    #       "name": "Which Staircase Should I Use"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Something to Remember"
    #     }
    #   ]
    # }
    field(:totalItems, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=0)"
    )

    # URI: https://www.w3.org/ns/activitystreams#items
    # Identifies the items contained in a collection. The items might be ordered or unordered.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's notes",
    #   "type": "Collection",
    #   "totalItems": 2,
    #   "items": [
    #     {
    #       "type": "Note",
    #       "name": "Reminder for Going-Away Party"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Meeting 2016-11-17"
    #     }
    #   ]
    # }
    field(:items, struct(), structs: Properties.Items)

    # URI: https://www.w3.org/ns/activitystreams#current
    # In a paged Collection, indicates the page that contains the most recently updated member items.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's blog posts",
    #   "type": "Collection",
    #   "totalItems": 3,
    #   "current": "http://example.org/collection",
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    # -----------------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's blog posts",
    #   "type": "Collection",
    #   "totalItems": 3,
    #   "current": {
    #     "type": "Link",
    #     "summary": "Most Recent Items",
    #     "href": "http://example.org/collection"
    #   },
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    conditional_field(:current, Behaviour.ss()) do
      field(:current, struct(), struct: Properties.Current, hint: "currentMap")

      field(:current, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "current"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#first
    # In a paged Collection, indicates the furthest preceeding page of items in the collection.
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
    conditional_field(:first, Behaviour.ss()) do
      field(:first, struct(), struct: Properties.First, hint: "firstMap")

      field(:first, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "first"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#last
    # In a paged Collection, indicates the furthest proceeding page of the collection.
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
    conditional_field(:last, Behaviour.ss()) do
      field(:last, struct(), struct: Properties.Last, hint: "lastMap")

      field(:last, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "last"
      )
    end
  end
end
