defmodule ActivityStream.Type.Activity.Properties.Target do
  use GuardedStruct

  # URI: URI: https://www.w3.org/ns/activitystreams#target
  # Describes the indirect object, or target, of the activity.
  # The precise meaning of the target is largely dependent on the type of action
  # being described but will often be the object of the English preposition "to".
  # For instance, in the activity "John added a movie to his wishlist",
  # the target of the activity is John's wishlist. An activity can have more than one target.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain:	Activity
  # Example:
  # {
  #   "actor": "http://sally.example.org",
  #   "object": "http://example.org/posts/1",
  #   "target": "http://john.example.org"
  # }
  # ----------------------------------------------------
  # {
  #   "actor": "http://sally.example.org",
  #   "object": "http://example.org/posts/1",
  #   "target": {
  #     "type": "Person",
  #     "name": "John"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
