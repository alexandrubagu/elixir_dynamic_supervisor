defmodule TestApp.Tracker do
  use Agent
  defstruct [:arg, :matching_origin, :matching_destination, :matching_both, :box]

  def start_link(_) do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def query(%{"origin" => {x1, y1}, "destination" => {x2, y2}}) do
    query({x1, y1}, {x2, y2})
  end

  def query({x1, y1} = origin, {x2, y2} = destination) do
    cache_key = "#{__MODULE__}-#{x1}-#{y1}-#{x2}-#{y2}"
    cache = Agent.get(__MODULE__, fn state ->
      Map.get(state, cache_key)
    end)

    case cache do
      nil ->
        record = new_record(origin, destination)
        Agent.update(__MODULE__, &Map.put(&1, cache_key, record))
        record
      _ -> cache
    end
  end

  def get_queries() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  defp new_record(origin, destination) do
    record = Map.put(
      struct(__MODULE__),
      :arg,
      %{"origin" => origin, "destination" => destination}
    )

    Enum.reduce(TestApp.BoxManager.get_all_boxes, record, fn(box, record) ->
      cond do
        Envelope.contains?(box, origin) && Envelope.contains?(box, destination) ->
          Map.put(record, :matching_both, box)
        Envelope.contains?(box, origin) ->
          Map.put(record, :matching_origin, box)
        Envelope.contains?(box, destination) ->
          Map.put(record, :matching_destination, box)
        true ->
          record
      end
    end)
  end
end
