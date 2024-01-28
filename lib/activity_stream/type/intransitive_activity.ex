defmodule MishkaPub.ActivityStream.Type.IntransitiveActivity do
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

  # URI: https://www.w3.org/ns/activitystreams#OrderedCollection
  # Instances of IntransitiveActivity are a subtype of Activity representing
  # intransitive actions. The object property is therefore inappropriate for these activities.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # Inherits all properties from Activity except object.
  # context | type | summary | actor | target | result | origin | instrument
  # ---------------------------------------------------------------------------------------
  # Extends:	Activity
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

    # URI: https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
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
    conditional_field(:actor, Behaviour.ssls()) do
      field(:actor, struct(), struct: Properties.Actor, hint: "actorMap")
      field(:actor, Behaviour.lst(), structs: Properties.Actor, hint: "actorList")

      field(:actor, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "actor"
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
    conditional_field(:target, Behaviour.ss()) do
      field(:target, struct(), struct: Properties.Target, hint: "targetMap")

      field(:target, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "target"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#result
    # Describes the result of the activity. For instance, if a particular action
    # results in the creation of a new resource, the result property can
    # be used to describe that new resource.
    # Domain:	Activity
    # Example
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "name": "A question about robots",
    #   "id": "http://polls.example.org/question/1",
    #   "type": "Question",
    #   "content": "I'd like to build a robot to feed my cat. Which platform is best?",
    #   "oneOf": [
    #     {
    #       "name": "arduino"
    #     },
    #     {
    #       "name": "raspberry pi"
    #     }
    #   ],
    #   "replies": {
    #     "type": "Collection",
    #     "totalItems": 3,
    #     "items": [
    #       {
    #         "attributedTo": "http://sally.example.org",
    #         "inReplyTo": "http://polls.example.org/question/1",
    #         "name": "arduino"
    #       },
    #       {
    #         "attributedTo": "http://joe.example.org",
    #         "inReplyTo": "http://polls.example.org/question/1",
    #         "name": "arduino"
    #       },
    #       {
    #         "attributedTo": "http://john.example.org",
    #         "inReplyTo": "http://polls.example.org/question/1",
    #         "name": "raspberry pi"
    #       }
    #     ]
    #   },
    #   "result": {
    #     "type": "Note",
    #     "content": "Users are favoriting &quot;arduino&quot; by a 33% margin."
    #   }
    # }
    field(:result, struct(), struct: Properties.Result)

    # URI: https://www.w3.org/ns/activitystreams#origin
    # Describes an indirect object of the activity from which the activity is directed.
    # The precise meaning of the origin is the object of the English preposition "from".
    # For instance, in the activity "John moved an item to List B from List A",
    # the origin of the activity is "List A".
    # Domain:	Activity
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally moved the sales figures from Folder A to Folder B",
    #   "type": "Move",
    #   "actor": "http://sally.example.org",
    #   "object": {
    #     "type": "Document",
    #     "name": "sales figures"
    #   },
    #   "origin": {
    #     "type": "Collection",
    #     "name": "Folder A"
    #   },
    #   "target": {
    #     "type": "Collection",
    #     "name": "Folder B"
    #   }
    # }
    field(:origin, struct(), struct: Properties.Origin)

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
    field(:instrument, struct(), struct: Properties.Instrument)
  end
end
