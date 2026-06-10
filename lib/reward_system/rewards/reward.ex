defmodule RewardSystem.Rewards.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field :activity_type, :string
    field :points, :integer

    belongs_to :user, RewardSystem.Accounts.User

    timestamps()
  end

  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [:activity_type, :points, :user_id])
    |> validate_required([:activity_type, :points, :user_id])
  end
end
