defmodule MishkaPub.ActivityStream.Type.Link do
  use GuardedStruct
  alias ActivityStream.Behaviour
  alias ActivityStream.Type.Object.Properties

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

  # URI: https://www.w3.org/ns/activitystreams#Link
  # A Link is an indirect, qualified reference to a resource identified by a URL.
  # The fundamental model for links is established by [ RFC5988].
  # Many of the properties defined by the Activity Vocabulary allow values
  # that are either instances of Object or Link. When a Link is used,
  # it establishes a qualified relation connecting the subject (the containing object)
  # to the resource identified by the href. Properties of the Link are properties of
  # the reference as opposed to properties of the resource.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # href | rel | mediaType | name | hreflang | height | width | preview
  # ---------------------------------------------------------------------------------------
  # different Types (These can be Inherited or call the object again as child):
  # "Article", "Audio", "Document", "Event", "Image", "Note", "Page",
  # "Place", "Profile", "Relationship", "Tombstone", "Video"
  guardedstruct do
    # URI: https://www.w3.org/ns/activitystreams#context
    # Identifies the context within which the object exists or an activity was performed.
    # The notion of "context" used is intentionally vague. The intended function is to serve
    # as a means of grouping objects and activities that share a common originating context or purpose.
    # An example could be all activities relating to a common project or event.
    # Domain: Object
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    # URI: @type
    # Identifies the Object or Link type. Multiple values may be specified.
    # Domain: Object | Link
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])",
      default: "Link"
    )

    # URI: https://www.w3.org/ns/activitystreams#href
    # The target resource pointed to by a Link.
    # Domain: Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/abc",
    #   "mediaType": "text/html",
    #   "name": "Previous"
    # }
    field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")

    # URI: https://www.w3.org/ns/activitystreams#hreflang
    # The target resource pointed to by a Link.
    # Domain: Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/abc",
    #   "hreflang": "en",
    #   "mediaType": "text/html",
    #   "name": "Previous"
    # }
    field(:hreflang, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[en::fa])",
      default: "en"
    )

    # URI: https://www.w3.org/ns/activitystreams#rel
    # A link relation associated with a Link. The value must conform to both
    # the [HTML5] and [RFC5988] "link relation" definitions.
    # In the [HTML5], any string not containing the "space" U+0020,
    # "tab" (U+0009), "LF" (U+000A), "FF" (U+000C), "CR" (U+000D) or "," (U+002C)
    # characters can be used as a valid link relation.
    # Domain: Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/abc",
    #   "hreflang": "en",
    #   "mediaType": "text/html",
    #   "name": "Preview",
    #   "rel": ["canonical", "preview"]
    # }
    conditional_field(:rel, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:rel, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    # URI: https://www.w3.org/ns/activitystreams#name
    # A simple, human-readable, plain-text name for the object. HTML markup must not be included.
    # The name may be expressed using multiple language-tagged values.
    # Domain:	Object | Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Note",
    #   "name": "A simple note"
    # }
    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

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
    field(:nameMap, struct(), struct: Properties.NameMap, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#width
    # On a Link, specifies a hint as to the rendering width in device-independent pixels of the linked resource.
    # Domain:	Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/image.png",
    #   "height": 100,
    #   "width": 100
    # }
    field(:width, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    # URI: https://www.w3.org/ns/activitystreams#height
    # On a Link, specifies a hint as to the rendering height in device-independent pixels of the linked resource.
    # Domain:	Link
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/image.png",
    #   "height": 100,
    #   "width": 100
    # }
    field(:height, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=32, max_len=1200)"
    )

    # URI: https://www.w3.org/ns/activitystreams#preview
    # Identifies an entity that provides a preview of this object.
    # Domain: Link | Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Video",
    #   "name": "Cool New Movie",
    #   "duration": "PT2H30M",
    #   "preview": {
    #     "type": "Video",
    #     "name": "Trailer",
    #     "duration": "PT1M",
    #     "url": {
    #       "href": "http://example.org/trailer.mkv",
    #       "mediaType": "video/mkv"
    #     }
    #   }
    # }
    field(:preview, struct(), struct: Properties.Preview)
  end
end
