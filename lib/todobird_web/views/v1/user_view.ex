defmodule TodobirdWeb.V1.UserView do
  use TodobirdWeb, :view

  attributes [:id, :email, :name]
  has_many :todo_lists,
    serializer: TodobirdWeb.V1.TodoListView
end
