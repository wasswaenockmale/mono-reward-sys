defmodule RewardSystemWeb.RewardController do
  use RewardSystemWeb, :controller
  alias RewardSystem.{Repo, Accounts.User, Rewards.Reward, Rewards.Redemption}

  def earn_points(conn, %{"user_id" => user_id, "activity_type" => type, "value" => value}) do
    user = Repo.get!(User, user_id)
    points = case type do
      "purchase" -> String.to_integer(value) |> div(10)
      "referral" -> 50
      _ -> 0
    end

    changeset = User.changeset(user, %{points: user.points + points})
    Repo.update!(changeset)

    reward_changeset = Reward.changeset(%Reward{}, %{user_id: user.id, activity_type: type, points: points})
    Repo.insert!(reward_changeset)

    json(conn, %{status: "success", earned_points: points})
  end

  def redeem_points(conn, %{"user_id" => user_id, "points" => points}) do
    user = Repo.get!(User, user_id)
    points_to_redeem = String.to_integer(points)

    if user.points < points_to_redeem do
      json(conn, %{status: "error", message: "Not enough points"})
    else
      money_value = points_to_redeem * 10
      changeset = User.changeset(user, %{points: user.points - points_to_redeem, wallet_balance: user.wallet_balance + money_value})
      Repo.update!(changeset)

      redemption_changeset = Redemption.changeset(%Redemption{}, %{user_id: user.id, points_redeemed: points_to_redeem, money_credited: money_value})
      Repo.insert!(redemption_changeset)

      json(conn, %{status: "success", credited_money: money_value})
    end
  end
end
