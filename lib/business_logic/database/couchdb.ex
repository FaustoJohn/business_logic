defmodule BusinessLogic.Database.CouchDB do
  @uri Application.fetch_env!(:business_logic, :couch_db_url)

  def insert_document(table_name, data) when is_map(data) do
    id = UUID.uuid4()

    {:ok, response} = HTTPoison.put(@uri <> "/" <> table_name <> "/" <> id, Poison.encode!(data))

    if response.status_code == 201 do
      results = Poison.decode!(response.body, as: %{})

      if results["ok"] == true do
        {:ok, "document saved"}
      else
        # Return an error
        {:error, "An error occurred"}
      end
    else
      # Return an error
      {:error, "An error occurred while trying to add a new document"}
    end

    {:ok, id}
  end

  @doc """
  Updates the selected document with the provided data within the chosen database
  """
  def update_document(db_name, document_id, data) do
    {:ok, response} = HTTPoison.post(@uri <> "/" <> db_name <> "/" <> document_id, Poison.encode!(data))

    if response.status_code == 201 do
      results = Poison.decode!(response.body, as: %{})

      if results["ok"] == true do
        {:ok, "document saved"}
      else
        # Return an error
        {:error, "An error occurred"}
      end
    else
      # Return an error
      {:error, "An error occurred while trying to add a new document"}
    end

    {:ok, document_id}
  end

  @doc """
  Retrieves the information about the selected document
  """
  def get_document_by_id(db_name, document_id) do
    {:ok, response} = HTTPoison.get(@uri <> "/" <> db_name <> "/" <> document_id)

    if response.status_code == 201 do
      results = Poison.decode!(response.body, as: %{})

      if results["ok"] == true do
        {:ok, results}
      else
        # Return an error
        {:error, "An error occurred"}
      end
    else
      # Return an error
      {:error, "An error occurred while trying to add a new document"}
    end
  end

  @doc """
  Creates a database into CouchDB instance
  """
  def create_database(db_name) do
    if db_name == nil || db_name == "" do
      {:error, "Please provide a table name to be created"}
    else
      # Here we have the main body of the function after we have performed our validation on the 'db_name' parameter
      {:ok, response} = HTTPoison.put @uri <> "/" <> db_name

      if response.status_code == 201 do
        results = Poison.decode!(response.body, as: %{})

        if results["ok"] == true do
          {:ok, "created"}
        else
          # Return an error
          {:error, "An error occurred"}
        end
      else
        # Return an error
        {:error, "An error occurred while trying to create the table: " <> db_name}
      end
    end
  end
end
