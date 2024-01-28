defmodule ActivityStream.Type.Object.Properties.NameMap do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#name
  # A simple, human-readable, plain-text name for the object. HTML markup must not be included.
  # The name may be expressed using multiple language-tagged values.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # en | fa
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Owner: :name
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Note",
  #   "nameMap": {
  #     "en": "A simple note",
  #     "es": "Una nota sencilla",
  #     "zh-Hans": "一段简单的笔记"
  #   }
  # }
  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=250, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=250, min_len=3)"
    )
  end
end
