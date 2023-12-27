defmodule ActivityStream.Type.Collection.Properties.Items do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#items
  # Identifies the items contained in a collection. The items might be ordered or unordered.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain:	Collection
  # TODO: We should cover a standard properties, because the Ordered Items can be anything no limited
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Person"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
