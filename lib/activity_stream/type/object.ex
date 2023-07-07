defmodule MishkaPub.ActivityStream.Type.Object do
  alias MishkaPub.ActivityStream.Validator
  use GuardedStruct

  # TODO: Each field can check is there any validator function inside a module or not?
  # TODO: All the validator functions should have 2 params, field name as atom and the vlaue as any type
  # TODO: If developer set validator alone for each field you should consider __MODULE__.validator(:id, value)
  # TODO: If validator_module is not empty you should consider the module.validator for example
  # TODO: Create a build function that check all entries of struct as validator function and enforce
  # TODO: Need a function to show all enforce field
  # TODO: We should have a function which drops none-structed fields
  # TODO: We need a function check all the required field are sent or not, and show what field is not sent?
  # TODO: IF a field has no type it should pass okey!! pattern
  # TODO: The action function should pass like this {:error, :action, [{:error, :field, message}]} | {:ok, :action}
  # TODO: Top level validator as `guardedstruct` entires,
  # TODO: It should be able to process all the data and then send it to the validators of each field.
  # TODO: It can find it as main_validator in the module or user can set it as `guardedstruct` validator parameter
  guardedstruct main_validator: {MishkaPub.ActivityStream.Validator, :validator} do
    field(:id, String.t(), validator: {MishkaPub.ActivityStream.Validator, :validator})
    field(:type, String.t())
    field(:name, String.t(), default: "Joe")
    field(:content, String.t())
    field(:url, String.t())
    field(:published, DateTime.t())
    field(:updated, DateTime.t())
    field(:actor, String.t())
    field(:location, String.t())
    field(:attachment, String.t())
    field(:tag, String.t())
    field(:replies, list(String.t()))
    field(:attributedTo, String.t())
    field(:audience, String.t())
    field(:context, String.t())
    field(:endTime, DateTime.t())
    field(:generator, String.t())
    field(:icon, String.t())
    field(:image, String.t())
    field(:inReplyTo, String.t())
    field(:preview, String.t())
    field(:startTime, DateTime.t())
    field(:summary, String.t())
    field(:to, String.t())
    field(:bto, String.t())
    field(:cc, String.t())
    field(:bcc, String.t())
    field(:mediaType, String.t())
  end

  def main_validator(value) do
    IO.inspect(value)
  end
end
