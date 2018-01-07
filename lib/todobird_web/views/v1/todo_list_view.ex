defmodule TodobirdWeb.V1.TodoListView do
  use TodobirdWeb, :view

  attributes [:id, :name, :description]
  has_one :user,
    serializer: TodobirdWeb.V1.UserView,
    identifiers: :when_included
end
