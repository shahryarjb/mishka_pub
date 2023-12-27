defmodule MishkaPub.ActivityStream.Type.IntransitiveActivity do
  use GuardedStruct
  alias ActivityStream.Type.Activity.Properties
  alias ActivityStream.Behaviour

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
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Travel"
    )

    # URI: https://www.w3.org/ns/activitystreams#summary
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
    field(:result, struct(), struct: Properties.Result)

    # URI: https://www.w3.org/ns/activitystreams#origin
    # Describes an indirect object of the activity from which the activity is directed.
    # The precise meaning of the origin is the object of the English preposition "from".
    # For instance, in the activity "John moved an item to List B from List A",
    # the origin of the activity is "List A".
    # Domain:	Activity
    field(:origin, struct(), struct: Properties.Origin)

    # URI: https://www.w3.org/ns/activitystreams#instrument
    # Identifies one or more objects used (or to be used) in the completion of an Activity.
    # Domain:	Activity
    field(:instrument, struct(), struct: Properties.Instrument)
  end
end
