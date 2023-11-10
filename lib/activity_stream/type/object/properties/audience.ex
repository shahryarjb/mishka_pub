defmodule ActivityStream.Type.Object.Properties.Audience do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
