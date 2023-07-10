defmodule MishkaPub.ActivityStream.Type.Object do
  alias MishkaPub.ActivityStream.Validator
  use GuardedStruct

  # TODO: Need a function to show all enforce field
  # TODO: We need a function check all the required field are sent or not, and show what field is not sent?
  # TODO: The action function should pass like this {:error, :action, [{:error, :field, message}]} | {:ok, :action}
  # TODO: Top level validator as `guardedstruct` entires,
  # TODO: It should be able to process all the data and then send it to the validators of each field.
  # TODO: It can find it as main_validator in the module or user can set it as `guardedstruct` validator parameter
  guardedstruct main_validator: {Validator, :main_validator} do
    field(:id, String.t(), validator: {Validator, :validator})
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

  def validator(:url, value) do
    {:ok, :url, value}
  end

  def validator(:id, value) do
    {:ok, :url, value}
  end

  def validator(:name, value) do
    {:ok, :name, value}
  end

  def validator(name, value) do
    {:ok, name, value}
  end
end
