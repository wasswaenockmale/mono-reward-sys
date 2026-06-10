defmodule RewardSystem.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :message, :string

    belongs_to :user, RewardSystem.Accounts.User

    timestamps(updated_at: false)
  end

  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:message, :user_id])
    |> validate_required([:message, :user_id])
  end
end
