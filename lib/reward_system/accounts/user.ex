defmodule RewardSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :points, :integer, default: 0
    field :wallet_balance, :integer, default: 0

    has_many :rewards, RewardSystem.Rewards.Reward
    has_many :redemptions, RewardSystem.Rewards.Redemption
    has_many :notifications, RewardSystem.Notifications.Notification

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :points, :wallet_balance])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
