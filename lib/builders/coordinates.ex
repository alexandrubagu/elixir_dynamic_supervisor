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

        managers_pids = TestApp.BoxManager.get_all_managers_pids
        for {_, pid, :worker, [TestApp.BoxManager]} <- managers_pids do
          box = TestApp.BoxManager.get_box(pid)
          if Envelope.contains?(box, {x, y}) do
            ### Debug ###
            # IO.inspect "add to pid = #{inspect pid} point = #{inspect %Point{lat: x, long: y}}"

            TestApp.BoxManager.add_point(pid, %Point{lat: x, long: y})
          end
        end
      end)
    end)
    |> Stream.run
  end
end
