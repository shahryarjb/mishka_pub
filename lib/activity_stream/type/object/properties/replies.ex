defmodule ActivityStream.Type.Object.Properties.Replies do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      default: "Collection",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:totalItems, integer(), derive: "sanitize(tag=strip_tags) validate(ineteger)")

    sub_field(:items, struct()) do
      field(:summary, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )

      field(:type, String.t(),
        default: "Note",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:content, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
      )

      field(:inReplyTo, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")
    end
  end
end
