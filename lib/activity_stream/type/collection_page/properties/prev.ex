defmodule ActivityStream.Type.CollectionPage.Properties.Prev do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=Object)",
      default: "Link"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:href, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )
  end
end
