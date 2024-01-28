defmodule ActivityStream.Type.Object.Properties.Location do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#location
  # Indicates one or more physical or logical locations associated with the object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | longitude | latitude | altitude | units
  # ---------------------------------------------------------------------------------------
  # Domain: Object
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
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:longitude, float(), enforce: true, derive: "sanitize(tag=strip_tags) validate(float)")

    field(:latitude, float(), enforce: true, derive: "sanitize(tag=strip_tags) validate(float)")

    field(:altitude, integer(), enforce: true, derive: "sanitize(tag=strip_tags) validate(float)")

    field(:units, String.t(),
      default: "m",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[m::ft::km::mi])"
    )
  end
end
