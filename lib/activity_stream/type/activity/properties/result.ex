defmodule ActivityStream.Type.Activity.Properties.Result do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#result
  # Describes the result of the activity. For instance, if a particular action
  # results in the creation of a new resource, the result property can be used
  # to describe that new resource.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name
  # TODO:::Consideration: This Object should be changed based on our program.
  # Extra data
  # Because Question objects are also instances of Activity, the result property
  # can be used to express the results or outcome of the Question (as appropriate):
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
