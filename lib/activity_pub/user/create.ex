defmodule ActivityPub.User.Create do
  use GuardedStruct

  @types ["Application", "Group", "Organization", "Person", "Service"]

  # Derives
  @type_derive "sanitize(tag=strip_tags) validate(enum=String[#{Enum.join(@types, "::")}])"
  @name_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @email_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @preferredUsername_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @mobile_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=30, min_len=3)"
  @summary_derive "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"

  guardedstruct do
    field(:type, String.t(), derive: @type_derive, default: "Person")
    field(:name, String.t(), derive: @name_derive)
    field(:email, String.t(), derive: @email_derive)
    field(:preferredUsername, String.t(), derive: @preferredUsername_derive)
    field(:mobile, String.t(), derive: @mobile_derive)
    field(:summary, String.t(), derive: @summary_derive)
  end
end
