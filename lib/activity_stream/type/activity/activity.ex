defmodule MishkaPub.ActivityStream.Type.Activity do
  use GuardedStruct
  alias ActivityStream.Type.Activity.Properties
  alias ActivityStream.Behaviour

  @types [
    "Accept",
    "Add",
    "Announce",
    "Arrive",
    "Block",
    "Create",
    "Delete",
    "Dislike",
    "Flag",
    "Follow",
    "Ignore",
    "Invite",
    "Join",
    "Leave",
    "Like",
    "Listen",
    "Move",
    "Offer",
    "Question",
    "Reject",
    "Read",
    "Remove",
    "TentativeReject",
    "TentativeAccept",
    "Travel",
    "Undo",
    "Update",
    "View"
  ]

  # URI: https://www.w3.org/ns/activitystreams#Activity
  # An Activity is a subtype of Object that describes some form of action that may happen,
  # is currently happening, or has already happened. The Activity type itself serves as an
  # abstract base type for all types of activities. It is important to note that the Activity
  # type itself does not carry any specific semantics about the kind of action being taken.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # actor | object | target | result | origin | instrument
  # ---------------------------------------------------------------------------------------
  # different Types (These can be Inherited or call the object again as child):
  # Accept | Add | Announce | Arrive | Block | Create | Delete | Dislike | Flag |
  # Follow | Ignore | Invite | Join | Leave | Like | Listen | Move | Offer |
  # Question | Reject | Read | Remove | TentativeReject | TentativeAccept |
  # Travel | Undo | Update | View
  # ---------------------------------------------------------------------------------------
  # Extends:	Object
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
      default: "Create"
    )

    # URI:	https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # URI: https://www.w3.org/ns/activitystreams#actor
    # Describes one or more entities that either performed or are expected to perform the activity.
    # Any single activity can have multiple actors. The actor may be specified using an indirect Link.
    # Domain:	Activity
    # Subproperty Of:	attributedTo
    # Example:
    # {
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/foo"
    # }
    # ----------------------------------------------------
    # {
    #   "actor": {
    #     "type": "Person",
    #     "id": "http://sally.example.org",
    #     "summary": "Sally"
    #   },
    #   "object": "http://example.org/foo"
    # }
    # ----------------------------------------------------
    # {
    #   "actor": [
    #     "http://joe.example.org",
    #     {
    #       "type": "Person",
    #       "id": "http://sally.example.org",
    #       "name": "Sally"
    #     }
    #   ],
    #   "object": "http://example.org/foo"
    # }
    conditional_field(:actor, Behaviour.ssls(),
      structs: true,
      enforce: true,
      derive: "validate(list, not_empty)"
    ) do
      field(:actor, Behaviour.sls(),
        struct: Properties.Actor,
        derive: "validate(map, not_empty)",
        hint: "actorListMap"
      )

      field(:actor, struct(),
        structs: Properties.Actor,
        derive: "validate(list, not_empty)",
        hint: "actorMap"
      )

      field(:actor, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "actorStringUrl"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#Object
    # Describes an object of any kind. The Object type serves as the base type for
    # most of the other kinds of objects defined in the Activity Vocabulary, including other
    # Core types such as Activity, IntransitiveActivity, Collection and OrderedCollection.
    conditional_field(:object, Behaviour.ssls(),
      enforce: true,
      derive: "validate(either=[string, map], not_empty)"
    ) do
      field(:object, struct(),
        struct: MishkaPub.ActivityStream.Type.Object,
        derive: "validate(map, not_empty)",
        hint: "objectMap"
      )

      field(:object, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "object"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#target
    # Describes the indirect object, or target, of the activity.
    # The precise meaning of the target is largely dependent on the type of action
    # being described but will often be the object of the English preposition "to".
    # For instance, in the activity "John added a movie to his wishlist",
    # the target of the activity is John's wishlist. An activity can have more than one target.
    # Domain:	Activity
    # Example:
    # {
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": "http://john.example.org"
    # }
    # ----------------------------------------------------
    # {
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/posts/1",
    #   "target": {
    #     "type": "Person",
    #     "name": "John"
    #   }
    # }
    conditional_field(:target, Behaviour.ssls(), derive: "validate(map, not_empty)") do
      field(:target, struct(),
        struct: Properties.Target,
        derive: "validate(map, not_empty)",
        hint: "targetMap"
      )

      field(:target, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "targetStringUrl"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#result
    # Describes the result of the activity. For instance, if a particular action
    # results in the creation of a new resource, the result property can
    # be used to describe that new resource.
    # Domain:	Activity
    # Example
    # {
    #   "type": ["Activity", "http://www.verbs.example/Check"],
    #   "actor": "http://sally.example.org",
    #   "object": "http://example.org/flights/1",
    #   "result": {
    #     "type": "http://www.types.example/flightstatus",
    #     "name": "On Time"
    #   }
    # }
    field(:result, struct(), struct: Properties.Result, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#origin
    # Describes an indirect object of the activity from which the activity is directed.
    # The precise meaning of the origin is the object of the English preposition "from".
    # For instance, in the activity "John moved an item to List B from List A",
    # the origin of the activity is "List A".
    # Domain:	Activity
    # Example:
    # {
    #   "object": "http://example.org/posts/1",
    #   "target": {
    #     "type": "Collection",
    #     "name": "List B"
    #   },
    #   "origin": {
    #     "type": "Collection",
    #     "name": "List A"
    #   }
    # }
    field(:origin, struct(), struct: Properties.Origin, derive: "validate(map, not_empty)")

    # URI: https://www.w3.org/ns/activitystreams#instrument
    # Identifies one or more objects used (or to be used) in the completion of an Activity.
    # Domain:	Activity
    # Example:
    # {
    #   "actor": {
    #     "type": "Person",
    #     "name": "Sally"
    #   },
    #   "object": "http://example.org/foo.mp3",
    #   "instrument": {
    #     "type": "Service",
    #     "name": "Acme Music Service"
    #   }
    # }
    field(:instrument, struct(),
      struct: Properties.Instrument,
      derive: "validate(map, not_empty)"
    )
  end
end
