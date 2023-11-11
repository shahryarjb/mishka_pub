defmodule MishkaPub.ActivityStream.Type.Object do
  use GuardedStruct
  alias ActivityStream.Type.Object.Properties

  @object_and_link_types [
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
    field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=Object)",
      default: "Object"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:endTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")
    field(:startTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    field(:generator, struct(), struct: Properties.Generator)
    field(:icon, struct(), struct: Properties.Icon)
    field(:image, struct(), struct: Properties.Image)
    field(:inReplyTo, struct(), struct: Properties.InReplyTo)
    field(:location, struct(), struct: Properties.Location)
    field(:preview, struct(), struct: Properties.Preview)
    field(:published, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")
    field(:replies, struct(), struct: Properties.Replies)

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:summaryMap, struct(), struct: Properties.SummaryMap)
    field(:tag, struct(), struct: Properties.Tag)

    field(:updated, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    field(:url, struct(), struct: Properties.Url)

    field(:to, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:bto, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:cc, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:bcc, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")

    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    field(:duration, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
    )

    field(:contentMap, struct(), struct: Properties.ContentMap)
    field(:actor, struct(), struct: Properties.Actor)
    field(:attachment, struct(), struct: Properties.Attachment)
    field(:attributedTo, struct(), struct: Properties.AttributedTo)
    field(:audience, struct(), struct: Properties.Audience)
  end
end
