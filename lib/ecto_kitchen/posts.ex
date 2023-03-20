defmodule EctoKitchen.Posts do
  import Ecto.Query
  alias EctoKitchen.Repo
  alias EctoKitchen.Posts.Post

  def create_posts_from_keyword_list(posts_keyword_list) do
    Repo.insert_all(Post, posts_keyword_list)
  end

  def create_post(post_params) do
    %Post{}
    |> Post.changeset(post_params)
    |> Repo.insert!()
  end

  def get_post(id) do
    Repo.get!(Post, id)
  end

  def list_posts() do
    query = from(p in Post, select: [:id, :title, :author, :page_views])
    Repo.all(query)
  end

  def update_title(post, new_title) do
    post_id = Ecto.UUID.dump!(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [set: [title: ^new_title]]
      )

    Repo.update_all(query, [])
  end

  def increment_page_views(post) do
    post_id = Ecto.UUID.dump!(post.id)

    query =
      from("posts",
        where: [id: ^post_id],
        update: [inc: [page_views: 1]]
      )

    Repo.update_all(query, [])
  end

  def reset_post_title(post) do
    post_id = Ecto.UUID.dump!(post.id)
    query = from(p in Post, where: [id: ^post_id])
    Repo.update_all(query, set: [title: ""])
  end

  def delete_post(post) do
    query = from(p in Post, where: [id: ^post.id])
    Repo.delete_all(query, [])
  end

  def recent_category_posts_from_author(author, category, published_at) do
    query =
      Post
      |> where(author: ^author)
      |> where(category: ^category)
      |> where([p], p.published_at > ^published_at)
      |> order_by(desc: :published_at)

    Repo.all(query, [])
  end
end
