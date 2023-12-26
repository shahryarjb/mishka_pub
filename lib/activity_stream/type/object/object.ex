defmodule MishkaPub.ActivityStream.Type.Object do
  use GuardedStruct
  alias ActivityStream.Behaviour
  alias ActivityStream.Type.Object.Properties

  # This part can be extended and Inherits from object properties
  @types [
    "Object",
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

  # URI: https://www.w3.org/ns/activitystreams#Object
  # Describes an object of any kind. The Object type serves as the base type for
  # most of the other kinds of objects defined in the Activity Vocabulary, including other
  # Core types such as Activity, IntransitiveActivity, Collection and OrderedCollection.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # attachment | attributedTo | audience | content | context | name | endTime |
  #  generator | icon | image | inReplyTo | location | preview | published |
  #  replies | startTime | summary | tag | updated | url | to | bto |
  #  cc | bcc | mediaType | duration
  # ---------------------------------------------------------------------------------------
  # different Types (These can be Inherited or call the object again as child):
  # "Object", "Article", "Audio", "Document", "Event", "Image", "Note", "Page",
  # "Place", "Profile", "Relationship", "Tombstone", "Video"
  guardedstruct do
    # URI: @type
    # Identifies the Object or Link type. Multiple values may be specified.
    # Domain: Object | Link
    field(:type, String.t(),
      default: "Object",
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])"
    )

    # URI: https://www.w3.org/ns/activitystreams#context
    # Identifies the context within which the object exists or an activity was performed.
    # The notion of "context" used is intentionally vague. The intended function is to serve
    # as a means of grouping objects and activities that share a common originating context or purpose.
    # An example could be all activities relating to a common project or event.
    # Domain: Object
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url, max_len=160)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    # URI: @id
    # Provides the globally unique identifier for an Object or Link.
    # Domain: Object | Link
    # Ex: "id": "http://example.org/foo"
    # TODO: It should be check it works?
    conditional_field(:id, String.t(), auto: {Ecto.UUID, :generate}) do
      field(:id, Behaviour.uuid(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, uuid)"
      )

      field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)")
    end

    # URI: https://www.w3.org/ns/activitystreams#name
    # A simple, human-readable, plain-text name for the object. HTML markup must not be included.
    # The name may be expressed using multiple language-tagged values.
    # Domain:	Object | Link
    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=250, min_len=3)"
    )

    # Owner: :name
    field(:nameMap, struct(), struct: Properties.NameMap)

    # URI: https://www.w3.org/ns/activitystreams#endTime
    # The date and time describing the actual or expected ending time of the object.
    # When used with an Activity object, for instance, the endTime property specifies
    # the moment the activity concluded or is expected to conclude.
    # Domain:	Object
    field(:endTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI:	https://www.w3.org/ns/activitystreams#startTime
    # The date and time describing the actual or expected starting time of the object.
    # When used with an Activity object, for instance, the startTime property specifies
    # the moment the activity began or is scheduled to begin.
    # Domain: Object
    field(:startTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#generator
    # Identifies the entity (e.g. an application) that generated the object.
    # Domain:	Object
    # TODO: We should know, how mutch items we can use as the type of this key, ex `application`
    field(:generator, struct(), struct: Properties.Generator)

    # URI: https://www.w3.org/ns/activitystreams#icon
    # Indicates an entity that describes an icon for this object.
    # The image should have an aspect ratio of one (horizontal) to one (vertical)
    # and should be suitable for presentation at a small size.
    # Domain:	Object
    # TODO: it should be tested
    conditional_field(:icon, Behaviour.sls()) do
      field(:icon, Behaviour.lst(),
        structs: Properties.Icon,
        derive: "validate(list, not_empty, not_flatten_empty_item)"
      )

      field(:icon, struct(),
        struct: Properties.Icon,
        derive: "validate(map, not_empty)"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#image
    # Indicates an entity that describes an image for this object.
    # Unlike the icon property, there are no aspect ratio or display size limitations assumed.
    # Domain:	Object
    conditional_field(:image, Behaviour.sls()) do
      field(:image, Behaviour.lst(),
        structs: Properties.Image,
        derive: "validate(list, not_empty, not_flatten_empty_item)"
      )

      field(:image, struct(), struct: Properties.Image, derive: "validate(map, not_empty)")
    end

    # URI: https://www.w3.org/ns/activitystreams#inReplyTo
    # Indicates one or more entities for which this object is considered a response.
    # Domain:	Object
    conditional_field(:inReplyTo, Behaviour.sls()) do
      field(:inReplyTo, struct(),
        struct: Properties.InReplyTo,
        derive: "validate(map, not_empty)"
      )

      field(:inReplyTo, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#location
    # Indicates one or more physical or logical locations associated with the object.
    # Domain:	Object
    field(:location, struct(), struct: Properties.Location)

    # URI: https://www.w3.org/ns/activitystreams#preview
    # Identifies an entity that provides a preview of this object.
    # Domain:	Link | Object
    field(:preview, struct(), struct: Properties.Preview)

    # URI: https://www.w3.org/ns/activitystreams#published
    # The date and time at which the object was published
    # Domain:	Object
    field(:published, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#replies
    # Identifies a Collection containing objects considered to be responses to this object.
    # Domain:	Object
    field(:replies, struct(), struct: Properties.Replies)

    # URI:	https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # Owner: :summary
    field(:summaryMap, struct(), struct: Properties.SummaryMap)

    # URI: https://www.w3.org/ns/activitystreams#tag
    # One or more "tags" that have been associated with an objects. A tag can be any kind of Object.
    # The key difference between attachment and tag is that the former implies association by inclusion,
    # while the latter implies associated by reference.
    # Domain:	Object
    field(:tag, Behaviour.lst(),
      structs: Properties.Tag,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#updated
    # The date and time at which the object was updated
    # Domain:	Object
    field(:updated, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#url
    # Identifies one or more links to representations of the object
    # Domain:	Object
    conditional_field(:url, Behaviour.ssls()) do
      field(:url, Behaviour.lst(),
        structs: Properties.Url,
        derive: "validate(list, not_empty, not_flatten_empty_item)"
      )

      field(:url, struct(), struct: Properties.Url, derive: "validate(map, not_empty)")

      field(:url, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#to
    # Identifies an entity considered to be part of the public primary audience of an Object
    # Domain:	Object
    conditional_field(:to, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:to, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#bto
    # Identifies an Object that is part of the private primary audience of this Object.
    # Domain:	Object
    conditional_field(:bto, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:bto, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#cc
    # Identifies an Object that is part of the public secondary audience of this Object.
    # Domain:	Object
    conditional_field(:cc, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:cc, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#bcc
    # Identifies one or more Objects that are part of the private secondary audience of this Object.
    # Domain:	Object
    conditional_field(:bcc, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:bcc, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#mediaType
    # When used on a Link, identifies the MIME media type of the referenced resource.
    # When used on an Object, identifies the MIME media type of the value of the content property.
    # If not specified, the content property is assumed to contain text/html content.
    # TODO: We need to specify this part of object and name all types we can bring here
    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    # URI: https://www.w3.org/ns/activitystreams#duration
    # When the object describes a time-bound resource, such as an audio or video,
    # a meeting, etc, the duration property indicates the object's approximate duration.
    # The value must be expressed as an xsd:duration as defined by [ xmlschema11-2],
    # section 3.3.6 (e.g. a period of 5 seconds is represented as "PT0H0M5S").
    # Domain:	Object
    field(:duration, String.t(),
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, max_len=10, custom=[MishkaPub.Helper.Extra, is_duration?])"
    )

    # URI:	https://www.w3.org/ns/activitystreams#content
    # The content or textual representation of the Object encoded as a JSON string.
    # By default, the value of content is HTML.
    # The mediaType property can be used in the object to indicate a different content type.
    # The content may be expressed using multiple language-tagged values.
    # Domain:	Object
    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500, min_len=3)"
    )

    # Owner: :content
    field(:contentMap, struct(),
      struct: Properties.ContentMap,
      derive: "validate(map, not_empty)"
    )

    # URI: https://www.w3.org/ns/activitystreams#attachment
    # Identifies a resource attached or related to an object that potentially requires special handling.
    # The intent is to provide a model that is at least semantically similar to attachments in email.
    # Domain:	Object
    field(:attachment, Behaviour.lst(),
      structs: Properties.Attachment,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#attributedTo
    # Identifies one or more entities to which this object is attributed.
    # The attributed entities might not be Actors. For instance, an object might
    # be attributed to the completion of another activity.
    # Domain:	Link | Object
    conditional_field(:attributedTo, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:attributedTo, struct(),
        struct: Properties.AttributedTo,
        derive: "validate(map, not_empty)"
      )

      field(:attributedTo, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#audience
    # Identifies one or more entities that represent the total population of entities
    # for which the object can considered to be relevant.
    # Domain:	Object
    field(:audience, struct(), struct: Properties.Audience)

    # When we have these Properties: Relationship
    field(:object, struct(),
      domain: "?type=Equal[String>>Relationship]",
      struct: MishkaPub.ActivityStream.Type.Object
    )
  end
end
