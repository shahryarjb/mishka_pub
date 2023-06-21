defmodule MishkaPub.ActivityStream.Validator do
  # Based on https://elixirforum.com/t/create-behaviour-and-type-with-macro/
  @type action() :: :build | :validate

  @callback build(struct()) :: {:ok, action(), struct()} | {:error, action(), any()}
  @callback build(struct(), list(String.t())) ::
              {:ok, action(), struct()} | {:error, action(), any()}

  @callback validate(struct()) :: {:ok, action(), struct()} | {:error, action(), any()}
  @callback validate(struct(), list(String.t())) ::
              {:ok, action(), struct()} | {:error, action(), any()}

  def uri(_url) do
  end
end
