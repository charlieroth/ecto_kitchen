defmodule EctoKitchen.Accounts do
  alias EctoKitchen.Repo
  alias EctoKitchen.Accounts.{Account, Registration, Profile}

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
