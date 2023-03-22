defmodule EctoKitchen.Todos.ProjectItem do
  use Ecto.Schema
  alias EctoKitchen.Todos.{Project, TodoItem}

  schema "project_items" do
    belongs_to(:project, Project)
    belongs_to(:todo_item, TodoItem)
    timestamps()
  end
end
