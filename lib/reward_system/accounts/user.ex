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

  defp put_password_hash(changeset) do
    if password = get_change(changeset, :password) do
      change(changeset, hashed_password: Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
