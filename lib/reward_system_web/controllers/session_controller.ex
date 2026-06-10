defmodule RewardSystemWeb.SessionController do
  use RewardSystemWeb, :controller
  alias RewardSystem.Accounts.Auth

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
end
