# TEST

### Install
1. mix deps.get - get dependencies
2. iex -S mix - start project

### How to run it (iex console)
1. Run TestApp.Main.run:

iex(1)> TestApp.Main.run
:ok

2. You can integorate the API using the following calls:

iex(2)> TestApp.Tracker.query(%{"origin" => {120.9917, 14.6364}, "destination" => {1, 2}})
%TestApp.Tracker{
  arg: %{"destination" => {1, 2}, "origin" => {120.9917, 14.6364}},
  box: nil,
  matching_both: nil,
  matching_destination: nil,
  matching_origin: %Envelope{
    max_x: 120.99324000000004,
    max_y: 14.636650000000003,
    min_x: 120.98974000000004,
    min_y: 14.626190000000003
  }
}

iex(3)> TestApp.Tracker.query(%{"origin" => {0, 0}, "destination" => {120.9798, 14.5926}})
%TestApp.Tracker{
  arg: %{"destination" => {120.9798, 14.5926}, "origin" => {0, 0}},
  box: nil,
  matching_both: nil,
  matching_destination: %Envelope{
    max_x: 120.97985000000001,
    max_y: 14.59343,
    min_x: 120.97901000000002,
    min_y: 14.59234
  },
  matching_origin: nil
}

iex(4)> TestApp.Tracker.query(%{"origin" => {120.9917, 14.6364}, "destination" => {120.9917, 14.6364}})
%TestApp.Tracker{
  arg: %{"destination" => {120.9917, 14.6364}, "origin" => {120.9917, 14.6364}},
  box: nil,
  matching_both: %Envelope{
    max_x: 120.99324000000004,
    max_y: 14.636650000000003,
    min_x: 120.98974000000004,
    min_y: 14.626190000000003
  },
  matching_destination: nil,
  matching_origin: nil
}

3. You can get all queries by calling: 
iex(6)> TestApp.Tracker.get_queries
%{
  "Elixir.TestApp.Tracker-0-0-120.9798-14.5926" => %TestApp.Tracker{
    arg: %{"destination" => {120.9798, 14.5926}, "origin" => {0, 0}},
    box: nil,
    matching_both: nil,
    matching_destination: %Envelope{
      max_x: 120.97985000000001,
      max_y: 14.59343,
      min_x: 120.97901000000002,
      min_y: 14.59234
    },
    matching_origin: nil
  },
  "Elixir.TestApp.Tracker-120.9724-14.7462-120.9798-14.5926" => %TestApp.Tracker{
    arg: %{
      "destination" => {120.9798, 14.5926},
      "origin" => {120.9724, 14.7462}
    },
    box: nil,
    matching_both: nil,
    matching_destination: %Envelope{
      max_x: 120.97985000000001,
      max_y: 14.59343,
      min_x: 120.97901000000002,
      min_y: 14.59234
    },
    matching_origin: %Envelope{
      max_x: 120.97252,
      max_y: 14.746730000000003,
      min_x: 120.97217,
      min_y: 14.745920000000003
    }
  },
  "Elixir.TestApp.Tracker-120.9917-14.6364-1-2" => %TestApp.Tracker{
    arg: %{"destination" => {1, 2}, "origin" => {120.9917, 14.6364}},
    box: nil,
    matching_both: nil,
    matching_destination: nil,
    matching_origin: %Envelope{
      max_x: 120.99324000000004,
      max_y: 14.636650000000003,
      min_x: 120.98974000000004,
      min_y: 14.626190000000003
    }
  },
  "Elixir.TestApp.Tracker-120.9917-14.6364-120.9917-14.6364" => %TestApp.Tracker{
    arg: %{
      "destination" => {120.9917, 14.6364},
      "origin" => {120.9917, 14.6364}
    },
    box: nil,
    matching_both: %Envelope{
      max_x: 120.99324000000004,
      max_y: 14.636650000000003,
      min_x: 120.98974000000004,
      min_y: 14.626190000000003
    },
    matching_destination: nil,
    matching_origin: nil
  }
}



