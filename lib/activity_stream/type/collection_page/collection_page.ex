defmodule MishkaPub.ActivityStream.Type.CollectionPage do
  use GuardedStruct
  alias ActivityStream.Type.Collection.Properties
  alias ActivityStream.Type.CollectionPage.Properties.{Next, Prev}

  guardedstruct do
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=String::Object)",
      default: "CollectionPage"
    )

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    field(:items, struct(), structs: Properties.Items)
    field(:item, struct(), structs: Properties.Items)

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

    field(:partOf, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    conditional_field(:next, any()) do
      field(:next, struct(), struct: Next, hint: "nextMap")
      field(:next, String.t(), hint: "next")
    end

    conditional_field(:prev, any()) do
      field(:prev, struct(), struct: Prev, hint: "prevMap")
      field(:prev, String.t(), hint: "prev")
    end
  end
end
