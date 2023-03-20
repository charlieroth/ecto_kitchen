defmodule EctoKitchen.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoKitchen.Post

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "comments" do
    field(:author, :string)
    field(:text, :string)

    belongs_to(:post, Post, type: :binary_id)
  end

  def changeset(comment, params) do
    comment
    |> cast(params, [:author, :text])
    |> validate_required([:author, :text])
  end
end
