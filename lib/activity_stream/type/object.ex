defmodule MishkaPub.ActivityStream.Type.Object do
  use GuardedStruct

  guardedstruct do
    field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(equal=Object)",
      default: "Object"
    )

    field(:name, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:endTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")
    field(:startTime, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    sub_field(:generator, struct()) do
      field(:type, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )
    end

    sub_field(:icon, struct()) do
      field(:type, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Image)"
      )

      field(:summary, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      field(:url, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

      field(:width, integer(),
        derive: "sanitize(tag=strip_tags) validate(ineteger, min_len=32, max_len=1200)"
      )

      field(:height, integer(),
        derive: "sanitize(tag=strip_tags) validate(ineteger, min_len=32, max_len=1200)"
      )
    end

    sub_field(:image, struct()) do
      field(:type, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Image)"
      )

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      sub_field(:url, struct()) do
        field(:type, String.t(),
          derive: "sanitize(tag=strip_tags) validate(not_empty_string, equal=Link)"
        )

        field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

        field(:mediaType, String.t(),
          derive:
            "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
        )
      end
    end

    sub_field(:inReplyTo, struct()) do
      field(:summary, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=600)"
      )

      field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

      field(:content, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
      )
    end

    sub_field(:location, struct()) do
      field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      field(:longitude, float(), derive: "sanitize(tag=strip_tags) validate(float)")
      field(:latitude, float(), derive: "sanitize(tag=strip_tags) validate(float)")
      field(:altitude, integer(), derive: "sanitize(tag=strip_tags) validate(ineteger)")
      field(:units, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")
    end

    sub_field(:preview, struct()) do
      field(:type, String.t(),
        default: "Video",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      field(:duration, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )

      sub_field(:url, struct()) do
        field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

        field(:mediaType, String.t(),
          derive:
            "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
        )
      end
    end

    field(:published, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    sub_field(:replies, struct()) do
      field(:type, String.t(),
        default: "Collection",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:totalItems, integer(), derive: "sanitize(tag=strip_tags) validate(ineteger)")

      sub_field(:items, struct()) do
        field(:summary, String.t(),
          derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
        )

        field(:type, String.t(),
          default: "Note",
          derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
        )

        field(:content, String.t(),
          derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
        )

        field(:inReplyTo, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")
      end
    end

    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    sub_field(:summaryMap, struct()) do
      field(:en, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )

      field(:fa, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )
    end

    sub_field(:tag, struct()) do
      field(:type, String.t(),
        default: "Person",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )
    end

    field(:updated, DateTime.t(), derive: "sanitize(tag=strip_tags) validate(datetime)")

    sub_field(:url, struct()) do
      field(:type, String.t(),
        default: "Link",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:href, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

      field(:mediaType, String.t(),
        derive:
          "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"image/jpeg\"::\"image/png\"])"
      )
    end

    field(:to, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:bto, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:cc, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")
    field(:bcc, list(String.t()), derive: "sanitize(tag=strip_tags) validate(min_len=1)")

    field(:mediaType, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, enum=String[\"text/html\"])"
    )

    field(:duration, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:content, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
    )

    sub_field(:contentMap, struct()) do
      field(:en, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )

      field(:fa, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )
    end

    sub_field(:actor, struct()) do
      field(:type, String.t(),
        default: "Person",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:id, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")

      field(:summary, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
      )
    end

    sub_field(:attachment, struct()) do
      field(:type, String.t(),
        default: "Image",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:content, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500)"
      )

      field(:url, String.t(), derive: "sanitize(tag=strip_tags) validate(url)")
    end

    sub_field(:attributedTo, struct()) do
      field(:type, String.t(),
        default: "Person",
        derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
      )

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )
    end

    sub_field(:audience, struct()) do
      field(:type, String.t(), derive: "sanitize(tag=strip_tags) validate(not_empty_string)")

      field(:name, String.t(),
        derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
      )
    end
  end
end
