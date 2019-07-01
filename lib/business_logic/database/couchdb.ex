defmodule BusinessLogic.Database.CouchDB do
  @uri Application.fetch_env!(:business_logic, :couch_db_url)

  def insertDocument(tableName, data) when is_map(data) do
    id = UUID.uuid4()

    {:ok, response} = HTTPoison.put(@uri <> "/" <> tableName <> "/" <> id, Poison.encode!(data))

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
  def updateDocument(dbName, documentID, data) do
    {:ok, response} = HTTPoison.post(@uri <> "/" <> dbName <> "/" <> documentID, Poison.encode!(data))

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

    {:ok, documentID}
  end

  @doc """
  Retrieves the information about the selected document
  """
  def getDocumentByID(dbName, documentID) do
    {:ok, response} = HTTPoison.get(@uri <> "/" <> dbName <> "/" <> documentID)

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
  def createDatabase(dbName) do
    if dbName == nil || dbName == "" do
      {:error, "Please provide a table name to be created"}
    else
      # Here we have the main body of the function after we have performed our validation on the 'dbName' parameter
      {:ok, response} = HTTPoison.put @uri <> "/" <> dbName

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
        {:error, "An error occurred while trying to create the table: " <> dbName}
      end
    end
  end
end
