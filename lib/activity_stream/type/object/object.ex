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
  # generator | icon | image | inReplyTo | location | preview | published |
  # replies | startTime | summary | tag | updated | url | to | bto |
  # cc | bcc | mediaType | duration
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
    # TODO: add conditional field for "@context": {"@language": "en"} lang and url
    # TODO: Or "@context": ["https://www.w3.org/ns/activitystreams", {"@language": "en"}]
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url, max_len=160)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    # URI: @id
    # Provides the globally unique identifier for an Object or Link.
    # Domain: Object | Link
    # Ex: "id": "http://example.org/foo"
    # TODO: It should be check it works?
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "Foo",
    #   "id": "http://example.org/foo"
    # }
    conditional_field(:id, String.t(), auto: {Ecto.UUID, :generate}) do
      field(:id, Behaviour.uuid(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, uuid)"
      )

      field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

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
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=100, min_len=3)"
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

    # URI: https://www.w3.org/ns/activitystreams#endTime
    # The date and time describing the actual or expected ending time of the object.
    # When used with an Activity object, for instance, the endTime property specifies
    # the moment the activity concluded or is expected to conclude.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Event",
    #   "name": "Going-Away Party for Jim",
    #   "startTime": "2014-12-31T23:00:00-08:00",
    #   "endTime": "2015-01-01T06:00:00-08:00"
    # }
    field(:endTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI:	https://www.w3.org/ns/activitystreams#startTime
    # The date and time describing the actual or expected starting time of the object.
    # When used with an Activity object, for instance, the startTime property specifies
    # the moment the activity began or is scheduled to begin.
    # Domain: Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Event",
    #   "name": "Going-Away Party for Jim",
    #   "startTime": "2014-12-31T23:00:00-08:00",
    #   "endTime": "2015-01-01T06:00:00-08:00"
    # }
    field(:startTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#generator
    # Identifies the entity (e.g. an application) that generated the object.
    # Domain:	Object
    # TODO: We should know, how mutch items we can use as the type of this key, ex `application`
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "content": "This is all there is.",
    #   "generator": {
    #     "type": "Application",
    #     "name": "Exampletron 3000"
    #   }
    # }
    field(:generator, struct(), struct: Properties.Generator, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#icon
    # Indicates an entity that describes an icon for this object.
    # The image should have an aspect ratio of one (horizontal) to one (vertical)
    # and should be suitable for presentation at a small size.
    # Domain:	Object
    # TODO: it should be tested
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "content": "This is all there is.",
    #   "icon": {
    #     "type": "Image",
    #     "name": "Note icon",
    #     "url": "http://example.org/note.png",
    #     "width": 16,
    #     "height": 16
    #   }
    # }
    conditional_field(:icon, Behaviour.sls(), derive: "validate(either=[list, map], not_empty)") do
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
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Image",
    #   "name": "Cat Jumping on Wagon",
    #   "url": [
    #     {
    #       "type": "Link",
    #       "href": "http://example.org/image.jpeg",
    #       "mediaType": "image/jpeg"
    #     },
    #     {
    #       "type": "Link",
    #       "href": "http://example.org/image.png",
    #       "mediaType": "image/png"
    #     }
    #   ]
    # }
    conditional_field(:image, Behaviour.sls(), derive: "validate(either=[list, map], not_empty)") do
      field(:image, Behaviour.lst(),
        structs: Properties.Image,
        derive: "validate(list, not_empty, not_flatten_empty_item)"
      )

      field(:image, struct(), struct: Properties.Image, derive: "validate(map, not_empty)")
    end

    # URI: https://www.w3.org/ns/activitystreams#inReplyTo
    # Indicates one or more entities for which this object is considered a response.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "content": "This is all there is.",
    #   "inReplyTo": {
    #     "summary": "Previous note",
    #     "type": "Note",
    #     "content": "What else is there?"
    #   }
    # }
    conditional_field(:inReplyTo, Behaviour.sls(),
      derive: "validate(either=[string, map], not_empty)"
    ) do
      field(:inReplyTo, struct(),
        struct: Properties.InReplyTo,
        derive: "validate(map, not_empty)"
      )

      field(:inReplyTo, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#location
    # Indicates one or more physical or logical locations associated with the object.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Person",
    #   "name": "Sally",
    #   "location": {
    #     "name": "Over the Arabian Sea, east of Socotra Island Nature Sanctuary",
    #     "type": "Place",
    #     "longitude": 12.34,
    #     "latitude": 56.78,
    #     "altitude": 90,
    #     "units": "m"
    #   }
    # }
    field(:location, struct(), struct: Properties.Location, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#preview
    # Identifies an entity that provides a preview of this object.
    # Domain:	Link | Object
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
    field(:preview, struct(), struct: Properties.Preview, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#published
    # The date and time at which the object was published
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "content": "Fish swim.",
    #   "published": "2014-12-12T12:12:12Z"
    # }
    field(:published, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#replies
    # Identifies a Collection containing objects considered to be responses to this object.
    # Domain:	Object
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
    field(:replies, struct(), struct: Properties.Replies, derive: "validate(map, not_empty)")

    # URI:	https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "Cane Sugar Processing",
    #   "type": "Note",
    #   "summary": "A simple <em>note</em>"
    # }
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # Owner: :summary
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "Cane Sugar Processing",
    #   "type": "Note",
    #   "summaryMap": {
    #     "en": "A simple <em>note</em>",
    #     "es": "Una <em>nota</em> sencilla",
    #     "zh-Hans": "一段<em>简单的</em>笔记"
    #   }
    # }
    field(:summaryMap, struct(),
      struct: Properties.SummaryMap,
      derive: "validate(map, not_empty)"
    )

    # URI: https://www.w3.org/ns/activitystreams#tag
    # One or more "tags" that have been associated with an objects. A tag can be any kind of Object.
    # The key difference between attachment and tag is that the former implies association by inclusion,
    # while the latter implies associated by reference.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Image",
    #   "summary": "Picture of Sally",
    #   "url": "http://example.org/sally.jpg",
    #   "tag": [
    #     {
    #       "type": "Person",
    #       "id": "http://sally.example.org",
    #       "name": "Sally"
    #     }
    #   ]
    # }
    field(:tag, Behaviour.lst(),
      structs: Properties.Tag,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#updated
    # The date and time at which the object was updated
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "Cranberry Sauce Idea",
    #   "type": "Note",
    #   "content": "Mush it up so it does not have the same shape as the can.",
    #   "updated": "2014-12-12T12:12:12Z"
    # }
    field(:updated, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    # URI: https://www.w3.org/ns/activitystreams#url
    # Identifies one or more links to representations of the object
    # Domain:	Object
    # Example:
    # -----------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Document",
    #   "name": "4Q Sales Forecast",
    #   "url": "http://example.org/4q-sales-forecast.pdf"
    # }
    # -----------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Document",
    #   "name": "4Q Sales Forecast",
    #   "url": {
    #     "type": "Link",
    #     "href": "http://example.org/4q-sales-forecast.pdf"
    #   }
    # }
    # -----------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Document",
    #   "name": "4Q Sales Forecast",
    #   "url": [
    #     {
    #       "type": "Link",
    #       "href": "http://example.org/4q-sales-forecast.pdf",
    #       "mediaType": "application/pdf"
    #     },
    #     {
    #       "type": "Link",
    #       "href": "http://example.org/4q-sales-forecast.html",
    #       "mediaType": "text/html"
    #     }
    #   ]
    # }
    conditional_field(:url, Behaviour.ssls(),
      derive: "validate(either=[string, map, list], not_empty)"
    ) do
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
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally offered the post to John",
    #   "type": "Offer",
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": "http://john.example.org",
    #   "to": [ "http://joe.example.org" ]
    # }
    conditional_field(:to, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:to, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#bto
    # Identifies an Object that is part of the private primary audience of this Object.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally offered a post to John",
    #   "type": "Offer",
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": "http://john.example.org",
    #   "bto": [ "http://joe.example.org" ]
    # }
    conditional_field(:bto, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:bto, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#cc
    # Identifies an Object that is part of the public secondary audience of this Object.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally offered a post to John",
    #   "type": "Offer",
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": "http://john.example.org",
    #   "cc": [ "http://joe.example.org" ]
    # }
    conditional_field(:cc, Behaviour.ls(),
      structs: true,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    ) do
      field(:cc, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    # URI: https://www.w3.org/ns/activitystreams#bcc
    # Identifies one or more Objects that are part of the private secondary audience of this Object.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally offered a post to John",
    #   "type": "Offer",
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": "http://john.example.org",
    #   "bcc": [ "http://joe.example.org" ]
    # }
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
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Link",
    #   "href": "http://example.org/abc",
    #   "hreflang": "en",
    #   "mediaType": "text/html",
    #   "name": "Next"
    # }
    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    # URI: https://www.w3.org/ns/activitystreams#duration
    # When the object describes a time-bound resource, such as an audio or video,
    # a meeting, etc, the duration property indicates the object's approximate duration.
    # The value must be expressed as an xsd:duration as defined by [ xmlschema11-2],
    # section 3.3.6 (e.g. a period of 5 seconds is represented as "PT0H0M5S").
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Video",
    #   "name": "Birds Flying",
    #   "url": "http://example.org/video.mkv",
    #   "duration": "PT2H"
    # }
    field(:duration, String.t(),
      domain: "!type=String[Audio, Video]",
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, max_len=10, custom=[MishkaPub.Helper.Extra, is_duration?])"
    )

    # URI:	https://www.w3.org/ns/activitystreams#content
    # The content or textual representation of the Object encoded as a JSON string.
    # By default, the value of content is HTML.
    # The mediaType property can be used in the object to indicate a different content type.
    # The content may be expressed using multiple language-tagged values.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "content": "A <em>simple</em> note"
    # }
    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500, min_len=3)"
    )

    # Owner: :content
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A simple note",
    #   "type": "Note",
    #   "contentMap": {
    #     "en": "A <em>simple</em> note",
    #     "es": "Una nota <em>sencilla</em>",
    #     "zh-Hans": "一段<em>简单的</em>笔记"
    #   }
    # }
    field(:contentMap, struct(),
      struct: Properties.ContentMap,
      derive: "validate(map, not_empty)"
    )

    # URI: https://www.w3.org/ns/activitystreams#attachment
    # Identifies a resource attached or related to an object that potentially requires special handling.
    # The intent is to provide a model that is at least semantically similar to attachments in email.
    # Domain:	Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Note",
    #   "name": "Have you seen my cat?",
    #   "attachment": [
    #     {
    #       "type": "Image",
    #       "content": "This is what he looks like.",
    #       "url": "http://example.org/cat.jpeg"
    #     }
    #   ]
    # }
    field(:attachment, Behaviour.lst(),
      structs: Properties.Attachment,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#attributedTo
    # Identifies one or more entities to which this object is attributed.
    # The attributed entities might not be Actors. For instance, an object might
    # be attributed to the completion of another activity.
    # Domain:	Link | Object
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Image",
    #   "name": "My cat taking a nap",
    #   "url": "http://example.org/cat.jpeg",
    #   "attributedTo": [
    #     {
    #       "type": "Person",
    #       "name": "Sally"
    #     }
    #   ]
    # }
    # ----------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "type": "Image",
    #   "name": "My cat taking a nap",
    #   "url": "http://example.org/cat.jpeg",
    #   "attributedTo": [
    #     "http://joe.example.org",
    #     {
    #       "type": "Person",
    #       "name": "Sally"
    #     }
    #   ]
    # }
    conditional_field(:attributedTo, Behaviour.ls(),
      enforce: true,
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
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "Holiday announcement",
    #   "type": "Note",
    #   "content": "Thursday will be a company-wide holiday. Enjoy your day off!",
    #   "audience": {
    #     "type": "http://example.org/Organization",
    #     "name": "ExampleCo LLC"
    #   }
    # }
    field(:audience, struct(), struct: Properties.Audience)

    # When we have these Properties: Relationship
    field(:object, struct(),
      domain: "?type=Equal[String>>Relationship]",
      struct: MishkaPub.ActivityStream.Type.Object
    )
  end

  # TODO: add source
  # "source": {
  #   "content": "این مطلب از یک منبع خاص گرفته شده است.",
  #   "mediaType": "text/plain"
  # }
end
