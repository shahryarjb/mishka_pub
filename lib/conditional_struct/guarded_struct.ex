defmodule GuardedStruct do
  @temporary_revaluation [
    :gs_fields,
    :gs_types,
    :gs_enforce_keys
  ]

  defmacro __using__(_) do
    quote do
      import GuardedStruct, only: [guardedstruct: 1, guardedstruct: 2]
    end
  end

  defmacro guardedstruct(opts \\ [], do: block) do
    ast = register_struct(block, opts)

    # It helps you create module inside module to define types
    case opts[:module] do
      nil ->
        quote do
          # Create a lexical scope.
          (fn -> unquote(ast) end).()
        end

      module ->
        quote do
          defmodule unquote(module) do
            unquote(ast)
          end
        end
    end
  end

  @doc false
  def register_struct(block, opts) do
    quote do
      Enum.each(unquote(@temporary_revaluation), fn attr ->
        Module.register_attribute(__MODULE__, attr, accumulate: true)
      end)

      Module.put_attribute(__MODULE__, :gs_enforce?, unquote(!!opts[:enforce]))

      import GuardedStruct
      # Leave the block with its orginal face
      unquote(block)

      # Point what field should be required
      @enforce_keys @gs_enforce_keys
      defstruct @gs_fields

      # Create type `t()` with `@opaque` option
      GuardedStruct.__type__(@gs_types, unquote(opts))
    end
  end

  @doc false
  defmacro __type__(types, opts) do
    if Keyword.get(opts, :opaque, false) do
      quote bind_quoted: [types: types] do
        @opaque t() :: %__MODULE__{unquote_splicing(types)}
      end
    else
      quote bind_quoted: [types: types] do
        @type t() :: %__MODULE__{unquote_splicing(types)}
      end
    end
  end

  defmacro field(name, type, opts \\ []) do
    quote bind_quoted: [name: name, type: Macro.escape(type), opts: opts] do
      GuardedStruct.__field__(name, type, opts, __ENV__)
    end
  end

  @doc false
  def __field__(name, type, opts, %Macro.Env{module: mod} = _env)
      when is_atom(name) do
    if mod |> Module.get_attribute(:gs_fields) |> Keyword.has_key?(name) do
      raise ArgumentError, "the field #{inspect(name)} is already set"
    end

    has_default? = Keyword.has_key?(opts, :default)
    enforce_by_default? = Module.get_attribute(mod, :gs_enforce?)

    enforce? =
      if is_nil(opts[:enforce]),
        do: enforce_by_default? && !has_default?,
        else: !!opts[:enforce]

    nullable? = !has_default? && !enforce?

    Module.put_attribute(mod, :gs_fields, {name, opts[:default]})
    Module.put_attribute(mod, :gs_types, {name, type_for(type, nullable?)})
    if enforce?, do: Module.put_attribute(mod, :gs_enforce_keys, name)
  end

  def __field__(name, _type, _opts, _env) do
    raise ArgumentError, "a field name must be an atom, got #{inspect(name)}"
  end

  # Makes the type nullable if the key is not enforced.
  defp type_for(type, false), do: type
  defp type_for(type, _), do: quote(do: unquote(type) | nil)
end
