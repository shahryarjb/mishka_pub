defmodule ActivityStream.Type.Object.Properties.Replies do
  use GuardedStruct
  alias ActivityStream.Behaviour

  # URI: https://www.w3.org/ns/activitystreams#replies
  # Identifies a Collection containing objects considered to be responses to this object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | totalItems | items --> type | content | inReplyTo
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A simple note",
  #   "type": "Note",
  #   "id": "http://www.test.example/notes/1",
  #   "content": "I am fine.",
  #   "replies": {
  #     "type": "Collection",
  #     "totalItems": 1,
  #     "items": [
  #       {
  #         "summary": "A response to the note",
  #         "type": "Note",
  #         "content": "I am glad to hear it.",
  #         "inReplyTo": "http://www.test.example/notes/1"
  #       }
  #     ]
  #   }
  # }
  guardedstruct do
    field(:type, String.t(),
      default: "Collection",
      derive: "sanitize(tag=strip_tags) validate(equal=String::Collection)"
    )

    field(:totalItems, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer)"
    )

    sub_field(:items, Behaviour.lst(),
      enforce: true,
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:summary, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )

      field(:type, String.t(),
        default: "Note",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=64, min_len=3)"
      )

      field(:content, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500, min_len=3)"
      )

      field(:inReplyTo, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end
  end
end
