defmodule EctoKitchen.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author, :string
      add :title, :string
      add :page_views, :integer
      timestamps()
    end
  end
end
