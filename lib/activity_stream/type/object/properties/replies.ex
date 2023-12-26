defmodule ActivityStream.Type.Object.Properties.Replies do
  use GuardedStruct
  alias ActivityStream.Behaviour

  guardedstruct do
    field(:type, String.t(),
      default: "Collection",
      derive: "sanitize(tag=strip_tags) validate(equal=String::Collection)"
    )

    field(:totalItems, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer)"
    )

    sub_field(:items, Behaviour.lst(), enforce: true, structs: true) do
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
