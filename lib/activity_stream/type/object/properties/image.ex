defmodule ActivityStream.Type.Object.Properties.Image do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Image)"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    sub_field(:url, struct()) do
      field(:type, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Link)"
      )

      field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

      field(:mediaType, String.t(),
        derive:
          "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
      )
    end
  end
end
