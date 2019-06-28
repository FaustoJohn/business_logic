defmodule BusinessLogic.NewAcquisition.Endpoint.UpdateCart do
  alias BusinessLogic.Database.CouchDB, as: DB
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  match "/", via: :get do
    case DB.createDatabase("sample_table") do
      {:ok, msg} -> send_resp(conn, 200, Poison.encode!(msg))
      {:error, msg} -> send_resp(conn, 500, Poison.encode!(msg))
      _ -> send_resp(conn, 500, "An error occurred")
    end
  end

  match _ do
      send_resp(conn, 404, "not found")
  end
end
