defmodule TodobirdWeb.V1.TodoListController do
  use TodobirdWeb, :controller

  # alias Todobird.Todos
  # alias Todobird.Todos.TodoList

  use JaResource
  plug JaResource

  import Ecto.Query

  def model, do: Todobird.Todos.TodoList

  def records(%Plug.Conn{params: %{"include" => include}}) do
    includes = String.split(include, ",")
    query = model()

    # Add a line like this for every preload you want to allow; JaResource requires that you add them one-by-one
    query = if "user" in includes, do: preload(query, :user)
    
    query
  end

  def records(%Plug.Conn{}) do
    model()
  end

  def filter(_conn, query, "user_id", user_id) do
    where(query, user_id: ^user_id)
  end
end
