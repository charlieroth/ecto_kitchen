defmodule EctoKitchen.Repo.Migrations.TodoProjectTables do
  use Ecto.Migration

  def change do
    create table(:todo_lists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string

      timestamps()
    end

    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

    create table(:todo_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :description, :string

      timestamps()
    end

    create table(:todo_list_items, primary_key: false) do
      add :todo_item_id, references(:todo_items, type: :uuid)
      add :project_id, references(:projects, type: :uuid)

      timestamps()
    end
  end
end
