defmodule BusinessLogic.NewAcquisition.Endpoint.SaveCart do
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
    offer = if Map.has_key?(conn.query_params, "offer"), do: conn.query_params["offer"], else: nil
    case DB.insertDocument(
      "sample_table",
      %BusinessLogic.Models.Cart{
        postcode: conn.query_params["postcode"],
        landline: conn.query_params["landline"],
        offer: offer
      }) do
      {:ok, msg} -> send_resp(conn, 200, Poison.encode!(msg))
      {:error, msg} -> send_resp(conn, 500, Poison.encode!(msg))
      _ -> send_resp(conn, 500, "An error occurred")
    end
  end

  match "/", via: :post do
    send_resp(conn, 200, Poison.encode!("test"))
  end

  match _ do
      send_resp(conn, 404, "not found")
  end
end
