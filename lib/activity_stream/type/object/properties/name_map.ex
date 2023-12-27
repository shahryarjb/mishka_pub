defmodule ActivityStream.Type.Object.Properties.NameMap do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#name
  # A simple, human-readable, plain-text name for the object. HTML markup must not be included.
  # The name may be expressed using multiple language-tagged values.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # en | fa
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Owner: :name
  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=250, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=250, min_len=3)"
    )
  end
end
