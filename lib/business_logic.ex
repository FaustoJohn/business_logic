defmodule BusinessLogic do
  use Application

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    [
      BusinessLogic.Router
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: BusinessLogic.Supervisor
    ]
  end
end
