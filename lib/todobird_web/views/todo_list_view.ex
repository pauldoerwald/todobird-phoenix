defmodule TodobirdWeb.TodoListView do
  use TodobirdWeb, :view
  alias TodobirdWeb.TodoListView

  def render("index.json", %{todo_lists: todo_lists}) do
    %{data: render_many(todo_lists, TodoListView, "todo_list.json")}
  end

  def render("show.json", %{todo_list: todo_list}) do
    %{data: render_one(todo_list, TodoListView, "todo_list.json")}
  end

  def render("todo_list.json", %{todo_list: todo_list}) do
    %{id: todo_list.id,
      name: todo_list.name,
      description: todo_list.description}
  end
end
