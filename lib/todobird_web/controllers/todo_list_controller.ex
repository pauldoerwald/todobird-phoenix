defmodule TodobirdWeb.TodoListController do
  use TodobirdWeb, :controller

  alias Todobird.Todos
  alias Todobird.Todos.TodoList

  action_fallback TodobirdWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    todo_lists = Todos.list_todo_lists(user_id)
    render(conn, "index.json", todo_lists: todo_lists)
  end

  def create(conn, %{"todo_list" => todo_list_params, "user_id" => user_id}) do
    with {:ok, %TodoList{} = todo_list} <- Todos.create_todo_list(user_id, todo_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_todo_list_path(conn, :show, todo_list, todo_list.user_id))
      |> render("show.json", todo_list: todo_list)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_list = Todos.get_todo_list!(id)
    render(conn, "show.json", todo_list: todo_list)
  end

  def update(conn, %{"id" => id, "todo_list" => todo_list_params}) do
    todo_list = Todos.get_todo_list!(id)

    with {:ok, %TodoList{} = todo_list} <- Todos.update_todo_list(todo_list, todo_list_params) do
      render(conn, "show.json", todo_list: todo_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_list = Todos.get_todo_list!(id)
    with {:ok, %TodoList{}} <- Todos.delete_todo_list(todo_list) do
      send_resp(conn, :no_content, "")
    end
  end
end
