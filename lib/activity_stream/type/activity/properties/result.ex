defmodule ActivityStream.Type.Activity.Properties.Result do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#result
  # Describes the result of the activity. For instance, if a particular action
  # results in the creation of a new resource, the result property can be used
  # to describe that new resource.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # ---------------------------------------------------------------------------------------
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
  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)"
    )
  end
end
