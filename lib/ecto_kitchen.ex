defmodule EctoKitchen do
  import Ecto.Query
  alias EctoKitchen.{Post, Profile, Account, Registration}
  alias EctoKitchen.Repo

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

  def complete_registration(form_params) do
    changeset = Registration.changeset(%Registration{}, form_params)

    if changeset.valid?() do
      registration = Ecto.Changeset.apply_changes(changeset)
      profile = to_profile(registration)
      account = to_account(registration)

      Ecto.Multi.new()
      |> Ecto.Multi.insert(:profile, profile)
      |> Ecto.Multi.insert(:account, account)
      |> Repo.transaction()
    else
      {:error, changeset}
    end
  end

  defp to_profile(registration) do
    %Profile{
      name: "#{registration.first_name} #{registration.last_name}",
      email: registration.email
    }
  end

  defp to_account(registration) do
    %Account{email: registration.email}
  end
end
