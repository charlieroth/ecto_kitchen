defmodule EctoKitchen.Library do
  import Ecto.Query
  alias EctoKitchen.Library.{Book, Visitor, Lendor}
  alias EctoKitchen.Repo

  def create_book(book_params) do
    %Book{}
    |> Book.changeset(book_params)
    |> Repo.insert()
  end

  def create_visitor(visitor_params) do
    %Visitor{}
    |> Visitor.changeset(visitor_params)
    |> Repo.insert()
  end

  def create_lendor(%{visitor_id: _visitor_id, book_id: _book_id} = lending_params) do
    %Lendor{}
    |> Lendor.changeset(lending_params)
    |> Repo.insert()
  end

  def get_lendor(lendor_id) do
    Lendor
    |> Repo.get!(lendor_id)
    |> Repo.preload([:book, :visitor])
  end

  def latest_lendors() do
    :needs_fixing
    # last_lendings =
    #   from(l in Lendor,
    #     group_by: l.book_id,
    #     select: %{
    #       book_id: l.book_id,
    #       # TODO(charlieroth): max/1 does not work with UUID, so this query needs to be rewritten
    #       last_lending_id: max(l.id)
    #     }
    #   )

    # query =
    #   from(l in Lendor,
    #     join: last in subquery(last_lendings),
    #     on: last.last_lending_id == l.id,
    #     join: b in assoc(l, :book),
    #     join: v in assoc(l, :visitor),
    #     select: {b.title, v.name}
    #   )

    # Repo.all(query, [])
  end
end
