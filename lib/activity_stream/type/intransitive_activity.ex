defmodule MishkaPub.ActivityStream.Type.IntransitiveActivity do
  use GuardedStruct
  alias ActivityStream.Type.Activity.Properties
  alias ActivityStream.Behaviour

  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Travel"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    conditional_field(:actor, Behaviour.ssls()) do
      field(:actor, struct(), struct: Properties.Actor, hint: "actorMap")
      field(:actor, Behaviour.lst(), structs: Properties.Actor, hint: "actorList")
      field(:actor, String.t(), hint: "actor")
    end

    conditional_field(:target, Behaviour.ssls()) do
      field(:target, struct(), struct: Properties.Target, hint: "targetMap")
      field(:target, String.t(), hint: "target")
    end

    field(:result, struct(), struct: Properties.Result)
    field(:origin, struct(), struct: Properties.Origin)
    field(:instrument, struct(), struct: Properties.Instrument)
  end
end
