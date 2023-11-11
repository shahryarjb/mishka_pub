defmodule MishkaPub.ActivityStream.Type.Activity do
  use GuardedStruct
  alias ActivityStream.Type.Activity.Properties

  @activity_types [
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

  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=Object)",
      default: "Activity"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    conditional_field(:actor, any()) do
      field(:actor, struct(), struct: Properties.Actor, hint: "actorMap")
      field(:actor, struct(), structs: Properties.Actor, hint: "actorList")
      field(:actor, String.t(), hint: "actor")
    end

    conditional_field(:object, any()) do
      field(:object, struct(), struct: MishkaPub.ActivityStream.Type.Object, hint: "objectMap")
      field(:object, String.t(), hint: "object")
    end

    conditional_field(:target, any()) do
      field(:target, struct(), struct: Properties.Target, hint: "targetMap")
      field(:target, String.t(), hint: "target")
    end

    field(:result, struct(), struct: Properties.Result)
    field(:origin, struct(), struct: Properties.Origin)
    field(:instrument, struct(), struct: Properties.Instrument)
  end
end
