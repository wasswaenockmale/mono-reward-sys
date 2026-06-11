defmodule RewardSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :points, :integer, default: 0
    field :wallet_balance, :integer, default: 0
    field :hashed_password, :string

    has_many :rewards, RewardSystem.Rewards.Reward
    has_many :redemptions, RewardSystem.Rewards.Redemption
    has_many :notifications, RewardSystem.Notifications.Notification

    timestamps()
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points, :wallet_balance])
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:wallet_balance, greater_than_or_equal_to: 0)
  end

  def hash_password(password) when is_binary(password) do
    :crypto.hash(:sha256, password)
    |> Base.encode16(case: :lower)
  end

  defp put_password_hash(changeset) do
    if password = get_change(changeset, :password) do
      change(changeset, hashed_password: hash_password(password))
    else
      changeset
    end
  end
end
