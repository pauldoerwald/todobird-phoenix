defmodule TodobirdWeb.V1.UserController do
  use TodobirdWeb, :controller

  use JaResource
  plug JaResource

  import Ecto.Query

  def model, do: Todobird.Accounts.User

  def records(%Plug.Conn{params: %{"include" => include}}) do
    includes = String.split(include, ",")
    query = model()
    query = if "todo_lists" in includes, do: preload(query, :todo_lists)
    query
  end

  def records(%Plug.Conn{}) do
    model()
  end

  def filter(_conn, query, "name", name) do
    where(query, name: ^name)
  end

  def filter(_conn, query, "email", email) do
    where(query, email: ^email)
  end
end
