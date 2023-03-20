defmodule EctoKitchen.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :string
      add :author, :string
      add :post_id, references(:posts, type: :uuid)

      timestamps()
    end

    create unique_index(:comments, [:post_id])
  end
end
