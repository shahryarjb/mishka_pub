defmodule MishkaPub.ActivityStream.Type.Object do
  alias MishkaPub.ActivityStream.Validator

  @type t :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          name: String.t(),
          content: String.t(),
          url: String.t(),
          published: DateTime.t(),
          updated: DateTime.t(),
          actor: String.t(),
          location: String.t(),
          attachment: String.t(),
          tag: String.t(),
          replies: list(String.t()),
          attributedTo: String.t(),
          audience: String.t(),
          context: String.t(),
          endTime: DateTime.t(),
          generator: String.t(),
          icon: String.t(),
          image: String.t(),
          inReplyTo: String.t(),
          preview: String.t(),
          startTime: DateTime.t(),
          summary: String.t(),
          to: String.t(),
          bto: String.t(),
          cc: String.t(),
          bcc: String.t(),
          mediaType: String.t()
        }

  defstruct [
    :id,
    :type,
    :name,
    :content,
    :url,
    :published,
    :updated,
    :actor,
    :location,
    :attachment,
    :tag,
    :replies,
    :attributedTo,
    :audience,
    :context,
    :endTime,
    :generator,
    :icon,
    :image,
    :inReplyTo,
    :preview,
    :startTime,
    :summary,
    :to,
    :bto,
    :cc,
    :bcc,
    :mediaType
  ]

  @behaviour Validator

  @impl true
  @spec build(t()) :: {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def build(%__MODULE__{} = params) do
    {:ok, :build, Map.merge(%__MODULE__{}, params)}
  rescue
    _e ->
      {:ok, :build, :unexpected}
  end

  @impl true
  @spec build(t(), list(String.t())) ::
          {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def build(%__MODULE__{} = params, _required_params) do
    {:ok, :build, Map.merge(%__MODULE__{}, params)}
  rescue
    _e ->
      {:ok, :build, :unexpected}
  end

  @impl true
  @spec build(t()) :: {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def validate(%__MODULE__{} = params) do
    {:ok, :validate, params}
  end

  @impl true
  @spec build(t(), list(String.t())) ::
          {:ok, Validator.action(), t()} | {:error, Validator.action(), any()}
  def validate(%__MODULE__{} = params, _required_params) do
    {:ok, :validate, params}
  end
end
