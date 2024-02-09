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
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "name": "Holiday announcement",
  #   "type": "Note",
  #   "content": "Thursday will be a company-wide holiday. Enjoy your day off!",
  #   "audience": {
  #     "type": "http://example.org/Organization",
  #     "name": "ExampleCo LLC"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
