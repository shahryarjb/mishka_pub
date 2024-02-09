defmodule ActivityStream.Type.Object.Properties.InReplyTo do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#inReplyTo
  # Indicates one or more entities for which this object is considered a response.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | summary | content
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A simple note",
  #   "type": "Note",
  #   "content": "This is all there is.",
  #   "inReplyTo": {
  #     "summary": "Previous note",
  #     "type": "Note",
  #     "content": "What else is there?"
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=300, min_len=10)"
    )

    field(:content, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=5000, min_len=10)"
    )
  end
end
