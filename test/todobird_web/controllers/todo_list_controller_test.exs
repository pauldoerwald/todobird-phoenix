defmodule TodobirdWeb.TodoListControllerTest do
  use TodobirdWeb.ConnCase

  alias Todobird.Todos
  alias Todobird.Todos.TodoList

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:todo_list) do
    {:ok, todo_list} = Todos.create_todo_list(@create_attrs)
    todo_list
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todo_lists", %{conn: conn} do
      conn = get conn, todo_list_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create todo_list" do
    test "renders todo_list when data is valid", %{conn: conn} do
      conn = post conn, todo_list_path(conn, :create), todo_list: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, todo_list_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, todo_list_path(conn, :create), todo_list: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo_list" do
    setup [:create_todo_list]

    test "renders todo_list when data is valid", %{conn: conn, todo_list: %TodoList{id: id} = todo_list} do
      conn = put conn, todo_list_path(conn, :update, todo_list), todo_list: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, todo_list_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, todo_list: todo_list} do
      conn = put conn, todo_list_path(conn, :update, todo_list), todo_list: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo_list" do
    setup [:create_todo_list]

    test "deletes chosen todo_list", %{conn: conn, todo_list: todo_list} do
      conn = delete conn, todo_list_path(conn, :delete, todo_list)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, todo_list_path(conn, :show, todo_list)
      end
    end
  end

  defp create_todo_list(_) do
    todo_list = fixture(:todo_list)
    {:ok, todo_list: todo_list}
  end
end
