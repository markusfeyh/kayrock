defmodule(Kayrock.AddPartitionsToTxn) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      transactional_id: nil,
      producer_id: nil,
      producer_epoch: nil,
      topics: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:add_partitions_to_txn)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [
        transactional_id: :string,
        producer_id: :int64,
        producer_epoch: :int16,
        topics: {:array, [topic: :string, partitions: {:array, :int32}]}
      ]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [
          serialize(:string, Map.get(struct, :transactional_id)),
          serialize(:int64, Map.get(struct, :producer_id)),
          serialize(:int16, Map.get(struct, :producer_epoch)),
          case(Map.get(struct, :topics)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.get(v, :topic)),
                    serialize_array(:int32, Map.get(v, :partitions))
                  ]
                end
              ]
          end
        ]
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

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  defmodule(V0.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, errors: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:add_partitions_to_txn)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [
        throttle_time_ms: :int32,
        errors:
          {:array,
           [topic: :string, partition_errors: {:array, [partition: :int32, error_code: :int16]}]}
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
      deserialize_field(:root, :errors, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:errors, :topic, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:errors, :partition_errors, Map.put(acc, :topic, val), rest)
    end

    defp(deserialize_field(:partition_errors, :partition, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:partition_errors, :error_code, Map.put(acc, :partition, val), rest)
    end

    defp(deserialize_field(:partition_errors, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:partition_errors, nil, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:errors, :partition_errors, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:partition_errors, :partition, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:errors, nil, Map.put(acc, :partition_errors, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(:root, :errors, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:errors, :topic, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :errors, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  def(min_vsn) do
    0
  end

  def(max_vsn) do
    0
  end
end
