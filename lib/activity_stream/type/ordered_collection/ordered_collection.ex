defmodule MishkaPub.ActivityStream.Type.OrderedCollection do
  use GuardedStruct
  alias ActivityStream.Type.Collection.Properties
  alias ActivityStream.Type.Collection.Properties.OrderedItems

  # totalItems | current | first | last | items
  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=String::Object)",
      default: "OrderedCollection"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:totalItems, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    conditional_field(:current, any()) do
      field(:current, struct(), struct: Properties.Current, hint: "currentMap")
      field(:current, String.t(), hint: "current")
    end

    conditional_field(:first, any()) do
      field(:first, struct(), struct: Properties.First, hint: "firstMap")
      field(:first, String.t(), hint: "first")
    end

    conditional_field(:last, any()) do
      field(:last, struct(), struct: Properties.Last, hint: "lastMap")
      field(:last, String.t(), hint: "last")
    end

    field(:orderedItems, struct(), structs: OrderedItems)
  end
end
