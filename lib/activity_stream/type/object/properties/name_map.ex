defmodule ActivityStream.Type.Object.Properties.NameMap do
  use GuardedStruct

  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )
  end
end
