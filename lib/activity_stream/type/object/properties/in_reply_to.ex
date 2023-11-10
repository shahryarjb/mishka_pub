defmodule ActivityStream.Type.Object.Properties.InReplyTo do
  use GuardedStruct

  guardedstruct do
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=600)"
    )

    field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
    )
  end
end
