defmodule MishkaPub.ActivityStream.Type.Object do
  alias MishkaPub.ActivityStream.Validator
  use GuardedStruct

  @type name :: String.t()

  guardedstruct do
    field(:id, String.t())
    field(:type, String.t())
    field(:name, name(), default: "Joe")
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

  @behaviour Validator

  @impl true
  @spec build(t()) :: {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def build(%__MODULE__{} = params) do
    {:ok, :build, Map.merge(%__MODULE__{}, params)}
  end

  @impl true
  @spec build(t(), list(String.t())) ::
          {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def build(%__MODULE__{} = params, _required_params) do
    {:ok, :build, Map.merge(%__MODULE__{}, params)}
  end

  @impl true
  @spec validate(t()) :: {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def validate(%__MODULE__{} = params) do
    {:ok, :validate, params}
  end

  @impl true
  @spec validate(t(), list(String.t())) ::
          {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def validate(%__MODULE__{} = params, _required_params) do
    {:ok, :validate, params}
  end
end
