defmodule EctoKitchen.Repo.Migrations.CorrectTodoListItemsTable do
  use Ecto.Migration

  def change do
    drop table(:todo_list_items)

    create table(:todo_list_items, primary_key: false) do
      add :todo_item_id, references(:todo_items, type: :uuid)
      add :todo_list_id, references(:todo_lists, type: :uuid)

      timestamps()
    end
  end
end
