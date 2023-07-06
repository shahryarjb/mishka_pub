defmodule MishkaPub.ActivityStream.Validator do
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

  def validator(:id, _id) do
    :ok
  end
end
