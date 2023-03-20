# Data Mapping & Validation

Schemas play a key role when validating and casting data through changesets.

Sometimes the best solution is not to completely avoid schemas but break large schemas into smaller ones. Perhaps one for reading and one for writing. Maybe one for your database and one for you forms

## Schemas are Mappers

An `Ecto.Schema` is used to map _any_ data source into an Elixir struct

If you have a form that submits data to your database, you can use a schema to map the form data into a struct that can be be later mapped to another schema that can be inserted into the database.

#### Scenario

You have a registration form that requires a user to enter their first and last name. You want to store the first and last name in the database but you want to display the full name in the UI.

You could use a `Profile` schema that includes `virtual` fields that would only be used to validate a changeset in the form but would not be saved in the database. This could be useful at first but if the requirements of the form expand, this schema quickly becomes bloated and mixes the concerns of the Client and API.

```elixir
defmodule MyApp.Profile do
  use Ecto.Schema

  schema "profiles" do
    field :name, :string
    field :first_name, :string, virtual: true
    field :last_name, :string, virtual: true
  end
end
```

An alternative could be to break the `Database <-> Ecto Schema <-> Forms / API` mapping into two parts. The first will cast and validate the external data which would be transformed and written to the database.

An `embedded_schema` can be used when you don't intend on persisting a schema anywhere

```elixir
defmodule RegistrationForm do
  use Ecto.Schema

  embedded_schema do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
  end

  def changeset(form, params) do
    form
    |> cast(params, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
```

```elixir
defmodule Profile do
  use Ecto.Schema

  schema "profiles" do
    field :name, :string
    field :email, :string
  end

  def changeset(profile, params) do
    profile
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end
end
```

Using this approach, you can first use the `RegistrationForm` schema to validate and cast the form data. Then you can use this validated data to create a `Profile` or any other derivative of the `RegistrationForm` schema.

```elixir
@spec create_profile_and_account(map()) :: {:ok, any()} | {:error, Ecto.Changeset.t()}
def complete_registration(form_params) do
  changeset = RegistrationForm.changeset(%RegistrationForm{}, registration_params)

  if changeset.valid? do
    registration = Ecto.Changeset.apply_changes(changeset)
    profile = MyApp.to_profile(changes)
    account = MyApp.to_account(changes)

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:profiles, profile)
    |> Ecto.Multi.insert(:accounts, account)
    |> Repo.transaction()

    {:ok, registration}d
  else
    changeset = %{changeset | action: :registration}
    {:error, registration_form}
  end
end

defp to_profile(registration) do
  %Profile{
    name: "#{registration.first_name} #{registration.last_name}"
  }
end

defp to_account(registration) do
  Map.take(registration, [:email])
end
```

By separating the UI and API logic your code becomes clearer and our data structures are more simple
