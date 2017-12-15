defmodule Todobird.Todos.TodoList do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todobird.Todos.TodoList


  schema "todo_lists" do
    field :description, :string
    field :name, :string
    belongs_to :user, Todobird.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%TodoList{} = todo_list, attrs) do
    todo_list
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name])
    |> cast_assoc(:user)
    |> assoc_constraint(:user)
  end
end
