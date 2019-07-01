defmodule BusinessLogic.Router do
  alias Plug.Cowboy
  use Plug.Router
  plug :match
  plug :dispatch

  forward("/v1/new-acq", to: BusinessLogic.NewAcquisition.Router)

  match _ do
      send_resp(conn, 404, "not found")
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    Cowboy.http(__MODULE__, [], [
      port: 6001
    ])
  end
end
