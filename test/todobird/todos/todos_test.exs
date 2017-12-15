defmodule Todobird.TodosTest do
  use Todobird.DataCase

  alias Todobird.Todos

  describe "todo_lists" do
    alias Todobird.Todos.TodoList

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def todo_list_fixture(attrs \\ %{}) do
      {:ok, todo_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_todo_list()

      todo_list
    end

    test "list_todo_lists/0 returns all todo_lists" do
      todo_list = todo_list_fixture()
      assert Todos.list_todo_lists() == [todo_list]
    end

    test "get_todo_list!/1 returns the todo_list with given id" do
      todo_list = todo_list_fixture()
      assert Todos.get_todo_list!(todo_list.id) == todo_list
    end

    test "create_todo_list/1 with valid data creates a todo_list" do
      assert {:ok, %TodoList{} = todo_list} = Todos.create_todo_list(@valid_attrs)
      assert todo_list.description == "some description"
      assert todo_list.name == "some name"
    end

    test "create_todo_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_todo_list(@invalid_attrs)
    end

    test "update_todo_list/2 with valid data updates the todo_list" do
      todo_list = todo_list_fixture()
      assert {:ok, todo_list} = Todos.update_todo_list(todo_list, @update_attrs)
      assert %TodoList{} = todo_list
      assert todo_list.description == "some updated description"
      assert todo_list.name == "some updated name"
    end

    test "update_todo_list/2 with invalid data returns error changeset" do
      todo_list = todo_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_todo_list(todo_list, @invalid_attrs)
      assert todo_list == Todos.get_todo_list!(todo_list.id)
    end

    test "delete_todo_list/1 deletes the todo_list" do
      todo_list = todo_list_fixture()
      assert {:ok, %TodoList{}} = Todos.delete_todo_list(todo_list)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_todo_list!(todo_list.id) end
    end

    test "change_todo_list/1 returns a todo_list changeset" do
      todo_list = todo_list_fixture()
      assert %Ecto.Changeset{} = Todos.change_todo_list(todo_list)
    end
  end
end
