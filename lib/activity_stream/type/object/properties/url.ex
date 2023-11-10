defmodule ActivityStream.Type.Object.Properties.Url do
  use GuardedStruct

  guardedstruct do
    field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

    field(:mediaType, String.t(),
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
    )
  end
end
