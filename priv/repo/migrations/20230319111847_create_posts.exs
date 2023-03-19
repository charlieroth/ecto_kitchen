defmodule EctoKitchen.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :author, :string
      add :title, :string
      add :page_views, :integer
      timestamps()
    end
  end
end
