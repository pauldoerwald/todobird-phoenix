defmodule Todobird.Repo.Migrations.CreateTodoLists do
  use Ecto.Migration

  def change do
    create table(:todo_lists) do
      add :name, :string, null: false
      add :description, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false
      timestamps()
    end

    create index(:todo_lists, [:user_id])
  end
end
