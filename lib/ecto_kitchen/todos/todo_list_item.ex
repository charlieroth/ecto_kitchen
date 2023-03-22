defmodule EctoKitchen.Todos.TodoListItem do
  use Ecto.Schema
  alias EctoKitchen.Todos.{TodoList, TodoItem}

  schema "todo_list_items" do
    belongs_to(:todo_list, TodoList)
    belongs_to(:todo_item, TodoItem)
    timestamps()
  end
end
