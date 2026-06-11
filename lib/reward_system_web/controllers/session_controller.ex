defmodule RewardSystemWeb.SessionController do
  use RewardSystemWeb, :controller
  alias RewardSystem.{Accounts.Auth, Accounts.User, Repo}

  def register(conn, %{"name" => name, "email" => email, "password" => password}) do
    attrs = %{name: name, email: email, password: password}

    case %User{} |> User.registration_changeset(attrs) |> Repo.insert() do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> json(%{status: "success", user_id: user.id, points: user.points, wallet_balance: user.wallet_balance})

      {:error, changeset} ->
        json(conn, %{status: "error", message: "Registration failed", errors: errors_from(changeset)})
    end
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate(email, password) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> json(%{status: "success", user_id: user.id})
      {:error, _} ->
        json(conn, %{status: "error", message: "Invalid credentials"})
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> json(%{status: "success", message: "Logged out"})
  end

  defp errors_from(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
