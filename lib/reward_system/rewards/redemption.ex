defmodule RewardSystem.Rewards.Redemption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "redemptions" do
    field :points_redeemed, :integer
    field :money_credited, :integer

    belongs_to :user, RewardSystem.Accounts.User

    timestamps()
  end

  def changeset(redemption, attrs) do
    redemption
    |> cast(attrs, [:points_redeemed, :money_credited, :user_id])
    |> validate_required([:points_redeemed, :money_credited, :user_id])
  end
end
