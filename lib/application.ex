defmodule TestApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, name: TestApp.BoxSupervisor, strategy: :one_for_one},
    ]

    opts = [strategy: :one_for_one, name: TestApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def get_managers do
    DynamicSupervisor.which_children(TestApp.BoxSupervisor)
  end
end
