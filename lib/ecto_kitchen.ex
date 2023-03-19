defmodule EctoKitchen do
  import Ecto.Query
  alias EctoKitchen.Post
  alias EctoKitchen.Repo

  @spec create_post(map()) :: Ecto.Changeset.t()
  def create_post(post_params) do
    %Post{}
    |> Post.changeset(post_params)
    |> Repo.insert()
  end

  def get_post(id) do
    Repo.get!(Post, id)
  end

  @spec list_posts() :: [%Post{}]
  def list_posts() do
    query = from(p in Post, select: [:id, :title, :author, :page_views])
    Repo.all(query)
  end

  def update_title(post, new_title) do
    {:ok, post_id} = Ecto.UUID.dump(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [set: [title: ^new_title]]
      )

    Repo.update_all(query, [])
  end

  def increment_page_views(post) do
    {:ok, post_id} = Ecto.UUID.dump(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [inc: [page_views: 1]]
      )

    Repo.update_all(query, [])
  end
end
