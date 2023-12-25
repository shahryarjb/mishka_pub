defmodule ActivityStream.Type.Activity.Properties.Actor do
  use GuardedStruct

  @types ["Application", "Group", "Organization", "Person", "Service"]

  guardedstruct do
    field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])",
      default: "Person"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )
  end
end
