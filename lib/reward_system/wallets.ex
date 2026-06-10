defmodule RewardSystem.Wallets do
  alias RewardSystem.{Repo, Wallets.Wallet}

  # Credit money to a user's wallet
  def credit(user_id, amount) do
    wallet = Repo.get_by(Wallet, user_id: user_id)

    case wallet do
      nil ->
        # Create wallet if it doesn't exist
        %Wallet{}
        |> Wallet.changeset(%{user_id: user_id, balance: amount})
        |> Repo.insert!()

      wallet ->
        new_balance = wallet.balance + amount
        wallet
        |> Wallet.changeset(%{balance: new_balance})
        |> Repo.update!()
    end
  end

  # Get wallet balance
  def get_balance(user_id) do
    case Repo.get_by(Wallet, user_id: user_id) do
      nil -> 0
      wallet -> wallet.balance
    end
  end
end
