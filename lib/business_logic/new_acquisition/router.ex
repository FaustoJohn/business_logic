defmodule BusinessLogic.NewAcquisition.Router do
  use Plug.Router
  plug :match
  plug :dispatch

  forward("/update-cart", to: BusinessLogic.NewAcquisition.Endpoint.UpdateCart)
  forward("/save-cart", to: BusinessLogic.NewAcquisition.Endpoint.SaveCart)

  match _ do
      send_resp(conn, 404, "not found")
  end
end
