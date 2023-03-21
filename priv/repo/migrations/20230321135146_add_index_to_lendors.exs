defmodule EctoKitchen.Repo.Migrations.AddIndexToLendors do
  use Ecto.Migration

  def change do
    create unique_index(:lendors, [:book_id, :visitor_id])
  end
end
