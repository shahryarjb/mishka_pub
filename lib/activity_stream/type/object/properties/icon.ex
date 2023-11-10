defmodule ActivityStream.Type.Object.Properties.Icon do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Image)"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:url, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

    field(:width, integer(),
      derive: "sanitize(tag=strip_tags) validate(ineteger, min_len=32, max_len=1200)"
    )

    field(:height, integer(),
      derive: "sanitize(tag=strip_tags) validate(ineteger, min_len=32, max_len=1200)"
    )
  end
end
