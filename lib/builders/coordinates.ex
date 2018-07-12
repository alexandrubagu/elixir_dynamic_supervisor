defmodule TestApp.Builder.Coordinates do
  @coordinates "data/coordinates.csv"

  alias TestApp.Entity.Point

  def build do
    @coordinates
    |> File.stream!()
    |> CSVParser.parse_stream()
    |> Stream.map(fn [lat, long] ->
      spawn(fn ->
        x = String.to_float(lat)
        y = String.to_float(long)

        managers = TestApp.Application.get_managers
        for {_, pid, :worker, [TestApp.BoxManager]} <- managers do
          box = TestApp.BoxManager.get_box(pid)
          if Envelope.contains?(box, {x, y}) do
            point = %Point{lat: x, long: y}
            IO.inspect "add to pid = #{inspect pid} point = #{inspect point}"

            TestApp.BoxManager.add_point(pid, %Point{lat: x, long: y})
          end
        end
      end)
    end)
    |> Stream.run
  end
end
