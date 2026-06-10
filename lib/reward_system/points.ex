defmodule RewardService.Points do
  alias RewardService.Repo
  alias RewardService.User

  # Assign points based on activity
  def assign_points(user_id, activity_type, value) do
    points =
      case activity_type do
        "purchase" -> round(value * 0.1)
        "referral" -> 50
        "login_streak" -> value * 2
        _ -> 0
      end

    user = Repo.get!(User, user_id)
    changeset = User.changeset(user, %{points: user.points + points})
    Repo.update!(changeset)

    {:ok, points}
  end

  # Redeem points for wallet credit
  def redeem_points(user_id, points_to_redeem) do
    user = Repo.get!(User, user_id)

    if user.points < points_to_redeem do
      {:error, "Not enough points"}
    else
      money_value = points_to_redeem * 10
      changeset = User.changeset(user, %{points: user.points - points_to_redeem})
      Repo.update!(changeset)

      WalletService.credit(user_id, money_value)
      {:ok, money_value}
    end
  end
end
