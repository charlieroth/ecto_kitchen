# Constraints And Upserts


## Checking For Constraint Errors
Checking for constraint errors is common when you are trying to avoid potential race conditions when inserting data with unique indexes.

`Ecto.Changeset.unqiue_constraint(:field_with_unique_index)` provides a way to place an assertion on a changeset so when you attempt to insert this data, it will either return `{:ok %SomeData{}}` or `{:error, changeset}`. This allows you to safely know whether or not that data exists already and you can then safe insert the data or retrieve it.

Example:

```elixir
@spec get_or_insert_tage(String.t()) :: %Tag{}
defp get_or_insert_tag(name) do
  %Tag{}
  |> change(name: name)
  |> unique_constraint(:name)
  |> Repo.insert()
  |> case do
    {:ok, tag} ->
      tag

    {:error, _changeset} ->
      Repo.get_by!(Tag, name: name)
  end
end
```

This however performs at most two queries on every attempted insertion of a Tag. Ecto provides a better option with upserts


## Upserts

Ecto supports the "upsert" command which is accomplish via the `:on_conflict` option. Rewritting the example above using upsert, you get a much more concise function. The key thing to remember is that the `:on_conflict` option must have something to detect a conflict on such as a `unique_index()`

```elixir
@spec get_or_insert_tage(String.t()) :: %Tag{}
defp get_or_insert_tag(name) do
  Repo.insert!(Tag{name: name}, on_conflict: :nothing)
end
```
