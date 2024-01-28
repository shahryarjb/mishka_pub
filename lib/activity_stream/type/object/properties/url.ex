defmodule ActivityStream.Type.Object.Properties.Url do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#url
  # Identifies one or more links to representations of the object
  # ---------------------------------------------------------------------------------------
  # Properties:
  # href | mediaType
  # ---------------------------------------------------------------------------------------
  # Domain:	Object
  # Example:
  # -----------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Document",
  #   "name": "4Q Sales Forecast",
  #   "url": "http://example.org/4q-sales-forecast.pdf"
  # }
  # -----------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Document",
  #   "name": "4Q Sales Forecast",
  #   "url": {
  #     "type": "Link",
  #     "href": "http://example.org/4q-sales-forecast.pdf"
  #   }
  # }
  # -----------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "type": "Document",
  #   "name": "4Q Sales Forecast",
  #   "url": [
  #     {
  #       "type": "Link",
  #       "href": "http://example.org/4q-sales-forecast.pdf",
  #       "mediaType": "application/pdf"
  #     },
  #     {
  #       "type": "Link",
  #       "href": "http://example.org/4q-sales-forecast.html",
  #       "mediaType": "text/html"
  #     }
  #   ]
  # }
  guardedstruct do
    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )

    field(:mediaType, String.t(),
      enforce: true,
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
    )
  end
end
