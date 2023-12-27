defmodule ActivityStream.Type.Link.Properties.NameMap do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#name
  # A simple, human-readable, plain-text name for the object. HTML markup must not be included.
  # The name may be expressed using multiple language-tagged values.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # en | fa
  # ---------------------------------------------------------------------------------------
  # Domain:	Object | Link
  # Owner: :content
  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
