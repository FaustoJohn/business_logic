defmodule BusinessLogic.Models.Cart do
  @enforce_keys [:postcode, :landline]
  defstruct [
    :postcode,
    :landline,
    :offer
  ]
end
