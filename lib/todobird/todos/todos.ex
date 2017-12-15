defmodule Todobird.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias Todobird.Repo

  alias Todobird.Todos.TodoList

  @doc """
  Returns the list of todo_lists.

  ## Examples

      iex> list_todo_lists()
      [%TodoList{}, ...]

  """
  def list_todo_lists(user_id) do
    Repo.all(from tl in TodoList, where: tl.user_id == ^user_id)
  end

  @doc """
  Gets a single todo_list.

  Raises `Ecto.NoResultsError` if the Todo list does not exist.

  ## Examples

      iex> get_todo_list!(123)
      %TodoList{}

      iex> get_todo_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo_list!(id), do: Repo.get!(TodoList, id)

  @doc """
  Creates a todo_list.

  ## Examples

      iex> create_todo_list(%{field: value})
      {:ok, %TodoList{}}

      iex> create_todo_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo_list(user_id, attrs \\ %{}) do
    {user_id, _} = Integer.parse(user_id)
    %TodoList{user_id: user_id}
    |> TodoList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_list.

  ## Examples

      iex> update_todo_list(todo_list, %{field: new_value})
      {:ok, %TodoList{}}

      iex> update_todo_list(todo_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo_list(%TodoList{} = todo_list, attrs) do
    todo_list
    |> TodoList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TodoList.

  ## Examples

      iex> delete_todo_list(todo_list)
      {:ok, %TodoList{}}

      iex> delete_todo_list(todo_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo_list(%TodoList{} = todo_list) do
    Repo.delete(todo_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_list changes.

  ## Examples

      iex> change_todo_list(todo_list)
      %Ecto.Changeset{source: %TodoList{}}

  """
  def change_todo_list(%TodoList{} = todo_list) do
    TodoList.changeset(todo_list, %{})
  end
end
