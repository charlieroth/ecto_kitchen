defmodule EctoKitchen.Library.Lendor do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoKitchen.Library.{Book, Visitor}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "lendors" do
    belongs_to(:book, Book)
    belongs_to(:visitor, Visitor)
  end

  def changeset(lendor, attrs \\ %{}) do
    lendor
    |> cast(attrs, [:book_id, :visitor_id])
    |> validate_required([:book_id, :visitor_id])
  end
end
