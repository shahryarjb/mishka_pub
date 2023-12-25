defmodule MishkaPub.ActivityStream.Type.Link do
  use GuardedStruct
  alias ActivityStream.Type.Link.Properties

  @type struct_list() :: struct() | list(struct())
  @type struct_list_string() :: struct_list() | String.t() | list(String.t())
  @type list_string() :: list(String.t())

  @types [
    "Article",
    "Audio",
    "Document",
    "Event",
    "Image",
    "Note",
    "Page",
    "Place",
    "Profile",
    "Relationship",
    "Tombstone",
    "Video"
  ]

  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])",
      default: "Link"
    )

    field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")

    field(:hreflang, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[en::fa])",
      default: "en"
    )

    conditional_field(:rel, list_string(), structs: true) do
      field(:rel, list(String.t()), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:nameMap, struct(), struct: Properties.NameMap)

    field(:width, integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    field(:height, integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    field(:preview, struct(), struct: ActivityStream.Type.Object.Properties.Preview)
  end
end
