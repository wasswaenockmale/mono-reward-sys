defmodule RewardSystemWeb.WalletController do
  use RewardSystemWeb, :controller
  alias RewardSystem.{Repo, Accounts.User, Wallets.Wallet}

  def show(conn, %{"user_id" => user_id}) do
    user = Repo.get(User, user_id)

    case user do
      nil ->
        json(conn, %{status: "error", message: "User not found"})

      _user ->
        wallet = Repo.get_by(Wallet, user_id: user_id) || %Wallet{balance: 0}

        json(conn, %{
          status: "success",
          user_id: user.id,
          points: user.points,
          wallet_balance: user.wallet_balance,
          wallet: %{id: wallet.id, balance: wallet.balance}
        })
    end
  end
end
