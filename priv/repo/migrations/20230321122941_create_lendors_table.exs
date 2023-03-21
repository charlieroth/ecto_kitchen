defmodule EctoKitchen.Repo.Migrations.CreateLendorsTable do
  use Ecto.Migration

  def change do
    create table(:lendors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :book_id, references(:books, type: :uuid)
      add :visitor_id, references(:visitors, type: :uuid)
    end
  end
end
