defmodule ActivityStream.Type.Activity.Properties.Origin do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#origin
  # Describes an indirect object of the activity from which the activity is directed.
  # The precise meaning of the origin is the object of the English preposition "from".
  # For instance, in the activity "John moved an item to List B from List A",
  # the origin of the activity is "List A".
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain:	Activity
  # Example:
  # {
  #   "object": "http://example.org/posts/1",
  #   "target": {
  #     "type": "Collection",
  #     "name": "List B"
  #   },
  #   "origin": {
  #     "type": "Collection",
  #     "name": "List A"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      enforce: true
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
