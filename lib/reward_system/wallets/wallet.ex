defmodule RewardSystem.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :balance, :integer, default: 0

    belongs_to :user, RewardSystem.Accounts.User

    timestamps()
  end

  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance, :user_id])
    |> validate_required([:balance, :user_id])
  end
end
