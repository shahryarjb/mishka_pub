defmodule ActivityStream.Type.Object.Properties.Attachment do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#attachment
  # Identifies a resource attached or related to an object that potentially requires special handling.
  # The intent is to provide a model that is at least semantically similar to attachments in email.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | content | url
  # ---------------------------------------------------------------------------------------
  # Domain: Object | Link
  guardedstruct do
    field(:type, String.t(),
      default: "Image",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80)"
    )

    field(:content, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
    )

    field(:url, String.t(), enforce: true, derive: "sanitize(tag=strip_tags) validate(url)")
  end
end
