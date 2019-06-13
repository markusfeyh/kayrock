defmodule(Kayrock.SaslHandshake) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(mechanism: nil, correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sasl_handshake)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [mechanism: :string]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [serialize(:string, Map.get(struct, :mechanism))]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V0.Request) do
    def(serialize(%V0.Request{} = struct)) do
      V0.Request.serialize(struct)
    end

    def(api_vsn(%V0.Request{})) do
      V0.Request.api_vsn()
    end

    def(response_deserializer(%V0.Request{})) do
      V0.Request.response_deserializer()
    end
  end

  defmodule(V1.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(mechanism: nil, correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sasl_handshake)
    end

    def(api_vsn) do
      1
    end

    def(response_deserializer) do
      &V1.Response.deserialize/1
    end

    def(schema) do
      [mechanism: :string]
    end

    def(serialize(%V1.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [serialize(:string, Map.get(struct, :mechanism))]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V1.Request) do
    def(serialize(%V1.Request{} = struct)) do
      V1.Request.serialize(struct)
    end

    def(api_vsn(%V1.Request{})) do
      V1.Request.api_vsn()
    end

    def(response_deserializer(%V1.Request{})) do
      V1.Request.response_deserializer()
    end
  end

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  def(get_request_struct(1)) do
    %V1.Request{}
  end

  defmodule(V0.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(error_code: nil, enabled_mechanisms: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sasl_handshake)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [error_code: :int16, enabled_mechanisms: {:array, :string}]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :error_code, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :enabled_mechanisms, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :enabled_mechanisms, acc, data)) do
      {val, rest} = deserialize_array(:string, data)
      deserialize_field(:root, nil, Map.put(acc, :enabled_mechanisms, Enum.reverse(val)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  defmodule(V1.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(error_code: nil, enabled_mechanisms: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:sasl_handshake)
    end

    def(api_vsn) do
      1
    end

    def(schema) do
      [error_code: :int16, enabled_mechanisms: {:array, :string}]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :error_code, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :enabled_mechanisms, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :enabled_mechanisms, acc, data)) do
      {val, rest} = deserialize_array(:string, data)
      deserialize_field(:root, nil, Map.put(acc, :enabled_mechanisms, Enum.reverse(val)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  def(deserialize(1, data)) do
    V1.Response.deserialize(data)
  end

  def(min_vsn) do
    0
  end

  def(max_vsn) do
    1
  end
end
