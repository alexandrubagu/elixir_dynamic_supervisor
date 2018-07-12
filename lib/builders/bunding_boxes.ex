defmodule TestApp.Builder.BoundingBoxes do
  alias TestApp.Entity.{
    Point,
    Box
  }

  @pairs "data/pairs.csv"

  def build do
    points = @pairs
    |> File.stream!()
    |> CSVParser.parse_stream()
    |> Stream.map(fn [lat, long] ->
      %Point{
        lat: String.to_float(lat),
        long: String.to_float(long)
      }
    end)
    |> Enum.to_list()

    0..Enum.count(points) - 2
    |> Enum.each(fn index ->
      x = Enum.at(points, index)
      y = Enum.at(points, index + 1)

      box = Envelope.from_geo(%Geo.Polygon{coordinates: [[{x.lat, x.long}, {y.lat, y.long}]]})
      child_spec = {TestApp.BoxManager, box: box, coordinates: []}

      DynamicSupervisor.start_child(TestApp.BoxSupervisor, child_spec)
    end)
  end
end
