defmodule MishkaPub.ActivityStream.Type.Activity do
  use GuardedStruct
  alias ActivityStream.Type.Activity.Properties

  @type struct_list() :: struct() | list(struct())
  @type struct_list_string() :: struct_list() | String.t() | list(String.t())
  @type list_string() :: list(String.t())

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

  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])",
      default: "Link"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # TODO: we need to check this part as a multi list
    conditional_field(:actor, struct_list_string()) do
      field(:actor, struct(), struct: Properties.Actor)

      conditional_field(:actor, struct_list(), structs: true) do
        field(:actor, struct(), struct: Properties.Actor)

        field(:actor, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
      end

      field(:actor, String.t(), derive: "sanitize(tag=strip_tags) validate(url, max_len=160)")
    end

    conditional_field(:object, struct_list_string()) do
      field(:object, struct(), struct: MishkaPub.ActivityStream.Type.Object, hint: "objectMap")

      field(:object, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "object"
      )
    end

    conditional_field(:target, struct_list_string()) do
      field(:target, struct(), struct: Properties.Target, hint: "targetMap")

      field(:target, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "target"
      )
    end

    field(:result, struct(), struct: Properties.Result)

    field(:origin, struct(), struct: Properties.Origin)

    field(:instrument, struct(), struct: Properties.Instrument)
  end
end
