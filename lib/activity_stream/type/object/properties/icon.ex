defmodule ActivityStream.Type.Object.Properties.Icon do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=String::Image)"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:url, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:width, integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    field(:height, integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )
  end
end
