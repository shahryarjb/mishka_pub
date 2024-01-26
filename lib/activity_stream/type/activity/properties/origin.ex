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
  # TODO:::Consideration: This Object should be changed based on our program.
  # ---------------------------------------------------------------------------------------
  # The origin and target properties of an Activity respectively identify
  # the entities from which and to which the action is directed. For instance,
  # in the English statement, "Sally moved the file from Folder A to Folder B",
  # the origin is "Folder A" and the target is "Folder B".
  # This activity is illustrated in the example below:
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally moved the sales figures from Folder A to Folder B",
  #   "type": "Move",
  #   "actor": "http://sally.example.org",
  #   "object": {
  #     "type": "Document",
  #     "name": "sales figures"
  #   },
  #   "origin": {
  #     "type": "Collection",
  #     "name": "Folder A"
  #   },
  #   "target": {
  #     "type": "Collection",
  #     "name": "Folder B"
  #   }
  # }
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
