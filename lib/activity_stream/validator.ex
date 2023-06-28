defmodule MishkaPub.ActivityStream.Validator do
  # TODO: We should test domo as validator
  @type title() :: any()
  @type content() :: any()
  @type url() :: any()
  @type time() :: any()
  @type actor() :: any()
  @type location() :: any()
  @type attachment() :: any()
  @type tag() :: any()
  @type replies() :: any()
  @type attributedTo() :: any()
  @type audience() :: any()
  @type context() :: any()
  @type generator() :: any()
  @type icon() :: any()
  @type image() :: any()
  @type inReplyTo() :: any()
  @type preview() :: any()
  @type summary() :: any()
  @type user_domain_address() :: any()
  @type mediaType() :: any()


  # Based on https://elixirforum.com/t/create-behaviour-and-type-with-macro/
  @type action() :: :build | :validate

  @callback build(struct()) :: {:ok, action(), struct()} | {:error, action(), any()}
  @callback build(struct(), list(String.t())) ::
              {:ok, action(), struct()} | {:error, action(), any()}

  @callback validate(struct()) :: {:ok, action(), struct()} | {:error, action(), any()}
  @callback validate(struct(), list(String.t())) ::
              {:ok, action(), struct()} | {:error, action(), any()}

  def validate_map(map, struct) do
    struct_fields = Map.keys(struct(struct))
    Enum.all?(Map.keys(map), fn item -> Enum.member?(struct_fields, item) end)
  end

  def uri(_url) do
  end
end
