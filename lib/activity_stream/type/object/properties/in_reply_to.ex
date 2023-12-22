defmodule ActivityStream.Type.Object.Properties.InReplyTo do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
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
