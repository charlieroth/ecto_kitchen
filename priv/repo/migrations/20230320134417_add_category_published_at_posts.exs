defmodule EctoKitchen.Repo.Migrations.AddCategoryPublishedAtPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :category, :string
      add :published_at, :naive_datetime
    end
  end
end
