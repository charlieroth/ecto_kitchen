defmodule EctoKitchen.Repo.Migrations.ProjectItemsTable do
  use Ecto.Migration

  def change do
    create table(:project_items) do
      add :todo_item_id, references(:todo_items, type: :uuid)
      add :project_id, references(:projects, type: :uuid)
      timestamps()
    end
  end
end
