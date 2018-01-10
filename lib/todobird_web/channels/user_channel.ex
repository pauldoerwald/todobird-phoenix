defmodule TodobirdWeb.UserChannel do
  use TodobirdWeb, :channel

  def join("user:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("user:" <> _user_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    broadcast socket, "ping", %{}
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("updatedTodoList", payload, socket) do
    {todo_list_id, _} = Integer.parse(payload["todoListId"])
    todo_list = Todobird.Todos.get_todo_list!(todo_list_id)
    # |> Todobird.Repo.preload(:user)
    # newpayload = JaSerializer.format(TodobirdWeb.V1.TodoListView, todo_list, %{}, %{include: "user"})
    newpayload = JaSerializer.format(TodobirdWeb.V1.TodoListView, todo_list)
    broadcast socket, "updatedTodoList", newpayload
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("deletedTodoList", payload, socket) do
    IO.inspect payload, label: "Payload"
    broadcast socket, "deletedTodoList", payload
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("newTodoList", payload, socket) do
    {todo_list_id, _} = Integer.parse(payload["todoListId"])
    todo_list = Todobird.Todos.get_todo_list!(todo_list_id)
    |> Todobird.Repo.preload(:user)
    newpayload = JaSerializer.format(TodobirdWeb.V1.TodoListView, todo_list, %{}, %{include: "user"})
    # newpayload = JaSerializer.format(TodobirdWeb.V1.TodoListView, todo_list)
    broadcast socket, "newTodoList", newpayload
    {:reply, {:ok, payload}, socket}
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (user:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
