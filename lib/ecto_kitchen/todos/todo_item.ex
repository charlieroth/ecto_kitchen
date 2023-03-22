defmodule EctoKitchen.Todos.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "todo_items" do
    field(:description, :string)
    timestamps()
  end

  def changeset(todo_item, attrs \\ %{}) do
    todo_item
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
