defmodule ActivityStream.Type.Object.Properties.Attachment do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      default: "Image",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
    )

    field(:url, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")
  end
end
