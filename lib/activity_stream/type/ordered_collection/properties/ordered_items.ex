defmodule ActivityStream.Type.Collection.Properties.OrderedItems do
  use GuardedStruct

  # URI: none
  # Ordered Items
  # ---------------------------------------------------------------------------------------
  # Properties:
  # name | type
  # ---------------------------------------------------------------------------------------
  # Domain: any
  # TODO: We should cover a standard properties, because the Ordered Items can be anything no limited
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally's notes",
  #   "type": "OrderedCollection",
  #   "totalItems": 2,
  #   "orderedItems": [
  #     {
  #       "type": "Note",
  #       "name": "A Simple Note"
  #     },
  #     {
  #       "type": "Note",
  #       "name": "Another Simple Note"
  #     }
  #   ]
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Note"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
