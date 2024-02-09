defmodule ActivityStream.Type.Object.Properties.Generator do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#generator
  # Identifies the entity (e.g. an application) that generated the object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A simple note",
  #   "type": "Note",
  #   "content": "This is all there is.",
  #   "generator": {
  #     "type": "Application",
  #     "name": "Exampletron 3000"
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
