defmodule EctoKitchen.Repo.Migrations.EnhancePostsAndTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

    create unique_index(:tags, [:name])

    create table(:posts_tags, primary_key: false) do
      add :post_id, references(:posts, type: :uuid)
      add :tag_id, references(:tags, type: :uuid)
    end
  end
end
