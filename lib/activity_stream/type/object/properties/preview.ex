defmodule ActivityStream.Type.Object.Properties.Preview do
  use GuardedStruct
  alias ActivityStream.Type.Object.Properties.Url

  guardedstruct do
    field(:type, String.t(),
      default: "Video",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:duration, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:url, struct(), struct: Url)
  end
end
