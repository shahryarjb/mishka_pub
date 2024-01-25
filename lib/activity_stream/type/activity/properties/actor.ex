defmodule ActivityStream.Type.Activity.Properties.Actor do
  use GuardedStruct

  @types ["Application", "Group", "Organization", "Person", "Service"]

  # URI: https://www.w3.org/ns/activitystreams#actor
  # Describes one or more entities that either performed or are expected to perform the activity.
  # Any single activity can have multiple actors. The actor may be specified using an indirect Link.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # id | type | summary
  # ---------------------------------------------------------------------------------------
  # Domain:	Activity
  # Subproperty Of:	attributedTo
  # Example:
  # {
  #   "actor": "http://sally.example.org",
  #   "object": "http://example.org/foo"
  # }
  # ----------------------------------------------------
  # {
  #   "actor": {
  #     "type": "Person",
  #     "id": "http://sally.example.org",
  #     "summary": "Sally"
  #   },
  #   "object": "http://example.org/foo"
  # }
  # ----------------------------------------------------
  # {
  #   "actor": [
  #     "http://joe.example.org",
  #     {
  #       "type": "Person",
  #       "id": "http://sally.example.org",
  #       "name": "Sally"
  #     }
  #   ],
  #   "object": "http://example.org/foo"
  # }
  guardedstruct do
    field(:id, String.t(), enforce: true, derive: "sanitize(tag=strip_tags) validate(url)")

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])",
      default: "Person"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )
  end
end
