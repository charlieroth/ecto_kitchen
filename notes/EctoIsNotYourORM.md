# Ecto Is Not Your ORM

Elixir is not an object-oriented language so Ecto cannot be an Object-relational Mapper (ORM).

## O Is For Objects

Elixir does not have methods, it has functions, a common feature in OO langauges.

Without having objects, Ecto can't be an ORM.

## Relational Mappers

“An Object-Relational Mapper is a technique for converting data between incompatible type systems, commonly databases, to objects, and back”

Similarly Ecto provides `schemas` that maps any data source into an Elxiir struct. When applied to your database, Ecto schemas are relational mappers so. While Ecto is not a relational mapper, it *contains* a relational mapper as part of the many different tools it offers.

The below schema ties the fields, invoked with the `field/3` function, the table `"users"` along with the fields inserted by the `timestamps/0` function.

```elixir
defmodule MyApp.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()
  end
end
```

Ecto schemas allow you to define the shape of the data once and use it to retrieve data from your db, and coordinate data changes on the schema.
