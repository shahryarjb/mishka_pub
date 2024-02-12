defmodule ActivityPub.User.Create do
  use GuardedStruct
  alias MishkaPub.Helper.Extra

  @types ["Application", "Group", "Organization", "Person", "Service"]

  # Derives
  @type_derive "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])"
  @name_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @email_derive "sanitize(tag=strip_tags) validate(not_empty_string, email)"
  @username_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=35, min_len=3)"
  @mobile_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @summary_derive "sanitize(tag=strip_tags) validate(string, max_len=160)"

  guardedstruct do
    field(:type, String.t(), derive: @type_derive, default: "Person")
    field(:name, String.t(), derive: @name_derive, enforce: true)
    field(:email, String.t(), derive: @email_derive, enforce: true)

    field(:preferredUsername, String.t(),
      derive: @username_derive,
      enforce: true,
      validator: {Extra, :validate_username}
    )

    field(:mobile, String.t(), derive: @mobile_derive)
    field(:summary, String.t(), derive: @summary_derive)
  end
end
