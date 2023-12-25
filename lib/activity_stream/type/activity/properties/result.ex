defmodule ActivityStream.Type.Activity.Properties.Result do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Person"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
