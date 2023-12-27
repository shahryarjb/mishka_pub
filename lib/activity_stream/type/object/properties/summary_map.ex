defmodule ActivityStream.Type.Object.Properties.SummaryMap do
  use GuardedStruct

  # URI:	https://www.w3.org/ns/activitystreams#summary
  # A natural language summarization of the object encoded as HTML.
  # Multiple language tagged summaries may be provided.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # en | fa
  # ---------------------------------------------------------------------------------------
  # Domain:	Object
  # Owner: :summary
  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )
  end
end
