defmodule EctoKitchen.Todos do
  alias EctoKitchen.Todos.{TodoList}
  alias EctoKitchen.Repo

  @spec create_todo_list(String.t(), %{String.t() => String.t()}) :: %TodoList{}
  def create_todo_list(title, items) do
    todo_items =
      for {_key, val} <- items, into: %{} do
        {Ecto.UUID.generate(), val}
      end

    %TodoList{}
    |> TodoList.changeset(%{title: title, todo_items: todo_items})
    |> Repo.insert!()
  end
end
