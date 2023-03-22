defmodule EctoKitchen.Todos.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoKitchen.Todos.TodoItem

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "projects" do
    field(:name, :string)
    many_to_many(:todo_items, TodoItem, join_through: "project_items")
    timestamps()
  end

  def changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:todo_items, required: true)
  end
end
