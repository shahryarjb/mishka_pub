defmodule ActivityStream.Type.Object.Properties.Location do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:longitude, float(), derive: "sanitize(tag=strip_tags) validate(float)")

    field(:latitude, float(), derive: "sanitize(tag=strip_tags) validate(float)")

    field(:altitude, integer(), derive: "sanitize(tag=strip_tags) validate(float)")

    field(:units, String.t(),
      default: "m",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[m::ft::km::mi])"
    )
  end
end
