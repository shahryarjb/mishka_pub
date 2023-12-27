defmodule ActivityStream.Type.Object.Properties.Audience do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#audience
  # Identifies one or more entities that represent the total population of entities
  # for which the object can considered to be relevant.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
