defmodule MishkaPub.ActivityStream.Type.CollectionPage do
  use GuardedStruct
  alias ActivityStream.Type.Collection.Properties
  alias ActivityStream.Type.CollectionPage.Properties.{Next, Prev}
  alias ActivityStream.Behaviour

  # URI: https://www.w3.org/ns/activitystreams#CollectionPage
  # Used to represent distinct subsets of items from a Collection.
  # Refer to the Activity Streams 2.0 Core for a complete description of the CollectionPage object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # Inherits all properties from Collection.
  # context | type | id | summary | items | totalItems | current | first
  # last | partOf | next | prev
  # ---------------------------------------------------------------------------------------
  # Extends:	Collection
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
      default: "CollectionPage"
    )

    # URI: @id
    # Provides the globally unique identifier for an Object or Link.
    # Domain: Object | Link
    # Ex: "id": "http://example.org/foo"
    # TODO: It should be check it works?
    conditional_field(:id, String.t(), auto: {Ecto.UUID, :generate}) do
      field(:id, Behaviour.uuid(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, uuid)"
      )

      field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # URI: https://www.w3.org/ns/activitystreams#items
    # Identifies the items contained in a collection. The items might be ordered or unordered.
    # Domain:	Collection
    field(:items, Behaviour.lst(),
      structs: Properties.Items,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#totalItems
    # A non-negative integer specifying the total number of objects contained by the logical
    # view of the collection. This number might not reflect the actual number
    # of items serialized within the Collection object instance.
    # Domain:	Collection
    field(:totalItems, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=0)"
    )

    # URI: https://www.w3.org/ns/activitystreams#current
    # In a paged Collection, indicates the page that contains the most recently updated member items.
    # Domain:	Collection
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
    conditional_field(:last, Behaviour.ss()) do
      field(:last, struct(), struct: Properties.Last, hint: "lastMap")

      field(:last, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "last"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#partOf
    # Identifies the Collection to which a CollectionPage objects items belong.
    # Domain:	CollectionPage
    field(:partOf, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url, max_len=160)"
    )

    # URI: https://www.w3.org/ns/activitystreams#next
    # In a paged Collection, indicates the next page of items.
    # Domain:	CollectionPage
    conditional_field(:next, Behaviour.ss()) do
      field(:next, struct(), struct: Next, hint: "nextMap")

      field(:next, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "next"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#prev
    # In a paged Collection, identifies the previous page of items.
    # Domain:	CollectionPage
    conditional_field(:prev, Behaviour.ss()) do
      field(:prev, struct(), struct: Prev, hint: "prevMap")

      field(:prev, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "prev"
      )
    end
  end
end
