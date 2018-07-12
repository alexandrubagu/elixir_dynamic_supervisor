defmodule TestApp.BoxManager do
  use GenServer

  alias TestApp.Entity.Point

  def init(opts) do
    box = Keyword.get(opts, :box)
    coordinates = Keyword.get(opts, :coordinates, [])

    {:ok, %{box: box, coordinates: coordinates}}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def get_box(pid) do
    GenServer.call(pid, :get_box)
  end

  def get_coordinates(pid) do
    GenServer.call(pid, :get_coordinates)
  end

  def add_point(pid, %Point{} = point) do
    GenServer.cast(pid, {:add_point, point})
  end

  def handle_call(:get_box, _from, %{box: box} = state) do
    {:reply, box, state}
  end

  def handle_call(:get_coordinates, _from, %{coordinates: coordinates} = state) do
    {:reply, coordinates, state}
  end

  def handle_cast({:add_point, point}, %{coordinates: coordinates} = state) do
    {:noreply, Map.put(state, :coordinates, [point | coordinates])}
  end
end
