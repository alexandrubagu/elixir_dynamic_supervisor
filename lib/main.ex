defmodule TestApp.Main do
  alias NimbleCSV, as: CSV
  CSV.define(CSVParser, escape: "\"")

  alias TestApp.Builder.{
    BoundingBoxes,
    Coordinates
  }

  def run do
    BoundingBoxes.build()
    Coordinates.build()
  end

end
