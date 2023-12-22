defmodule ActivityStream.Type.Object.Properties.Url do
  use GuardedStruct

  guardedstruct do
    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:mediaType, String.t(),
      enforce: true,
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
    )
  end
end
