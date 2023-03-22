defmodule EctoKitchen.Todos.TodoList do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoKitchen.Todos.{TodoItem}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "todo_lists" do
    field(:title, :string)
    many_to_many(:todo_items, TodoItem, join_through: "todo_list_items")
    timestamps()
  end

  def changeset(todo_list, attrs \\ %{}) do
    todo_list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:todo_items, required: true)
  end
end
