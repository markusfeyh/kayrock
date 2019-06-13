defmodule(Kayrock.DescribeGroups) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(group_ids: [], correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:describe_groups)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [group_ids: {:array, :string}]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [serialize_array(:string, Map.get(struct, :group_ids))]
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
    defstruct(group_ids: [], correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:describe_groups)
    end

    def(api_vsn) do
      1
    end

    def(response_deserializer) do
      &V1.Response.deserialize/1
    end

    def(schema) do
      [group_ids: {:array, :string}]
    end

    def(serialize(%V1.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [serialize_array(:string, Map.get(struct, :group_ids))]
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
    defstruct(groups: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:describe_groups)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [
        groups:
          {:array,
           [
             error_code: :int16,
             group_id: :string,
             state: :string,
             protocol_type: :string,
             protocol: :string,
             members:
               {:array,
                [
                  member_id: :string,
                  client_id: :string,
                  client_host: :string,
                  member_metadata: :bytes,
                  member_assignment: :bytes
                ]}
           ]}
      ]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :groups, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:groups, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:groups, :group_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:groups, :group_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :state, Map.put(acc, :group_id, val), rest)
    end

    defp(deserialize_field(:groups, :state, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :protocol_type, Map.put(acc, :state, val), rest)
    end

    defp(deserialize_field(:groups, :protocol_type, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :protocol, Map.put(acc, :protocol_type, val), rest)
    end

    defp(deserialize_field(:groups, :protocol, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :members, Map.put(acc, :protocol, val), rest)
    end

    defp(deserialize_field(:members, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :client_id, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :client_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :client_host, Map.put(acc, :client_id, val), rest)
    end

    defp(deserialize_field(:members, :client_host, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :member_metadata, Map.put(acc, :client_host, val), rest)
    end

    defp(deserialize_field(:members, :member_metadata, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, :member_assignment, Map.put(acc, :member_metadata, val), rest)
    end

    defp(deserialize_field(:members, :member_assignment, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, nil, Map.put(acc, :member_assignment, val), rest)
    end

    defp(deserialize_field(:groups, :members, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:members, :member_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:groups, nil, Map.put(acc, :members, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(:root, :groups, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:groups, :error_code, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :groups, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  defmodule(V1.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, groups: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:describe_groups)
    end

    def(api_vsn) do
      1
    end

    def(schema) do
      [
        throttle_time_ms: :int32,
        groups:
          {:array,
           [
             error_code: :int16,
             group_id: :string,
             state: :string,
             protocol_type: :string,
             protocol: :string,
             members:
               {:array,
                [
                  member_id: :string,
                  client_id: :string,
                  client_host: :string,
                  member_metadata: :bytes,
                  member_assignment: :bytes
                ]}
           ]}
      ]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data

      deserialize_field(
        :root,
        :throttle_time_ms,
        %__MODULE__{correlation_id: correlation_id},
        rest
      )
    end

    defp(deserialize_field(:root, :throttle_time_ms, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :groups, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:groups, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:groups, :group_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:groups, :group_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :state, Map.put(acc, :group_id, val), rest)
    end

    defp(deserialize_field(:groups, :state, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :protocol_type, Map.put(acc, :state, val), rest)
    end

    defp(deserialize_field(:groups, :protocol_type, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :protocol, Map.put(acc, :protocol_type, val), rest)
    end

    defp(deserialize_field(:groups, :protocol, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:groups, :members, Map.put(acc, :protocol, val), rest)
    end

    defp(deserialize_field(:members, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :client_id, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :client_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :client_host, Map.put(acc, :client_id, val), rest)
    end

    defp(deserialize_field(:members, :client_host, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :member_metadata, Map.put(acc, :client_host, val), rest)
    end

    defp(deserialize_field(:members, :member_metadata, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, :member_assignment, Map.put(acc, :member_metadata, val), rest)
    end

    defp(deserialize_field(:members, :member_assignment, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, nil, Map.put(acc, :member_assignment, val), rest)
    end

    defp(deserialize_field(:groups, :members, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:members, :member_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:groups, nil, Map.put(acc, :members, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(:root, :groups, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:groups, :error_code, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :groups, Enum.reverse(vals)), rest)
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
