alias RewardSystem.{Accounts.User, Repo}

seed_users = [
  %{name: "Demo User", email: "demo@example.com", password: "password123", points: 250, wallet_balance: 0},
  %{name: "Tester One", email: "tester1@example.com", password: "password123", points: 500, wallet_balance: 10},
  %{name: "Tester Two", email: "tester2@example.com", password: "password123", points: 75, wallet_balance: 0}
]

Enum.each(seed_users, fn attrs ->
  case Repo.get_by(User, email: attrs.email) do
    nil ->
      user =
        %User{}
        |> User.registration_changeset(Map.take(attrs, [:name, :email, :password]))
        |> Repo.insert!()

      user
      |> Ecto.Changeset.change(%{points: attrs.points, wallet_balance: attrs.wallet_balance})
      |> Repo.update!()

      IO.puts("Seeded user: #{attrs.email} (points: #{attrs.points})")

    existing_user ->
      IO.puts("User already exists: #{existing_user.email}")
  end
end)
