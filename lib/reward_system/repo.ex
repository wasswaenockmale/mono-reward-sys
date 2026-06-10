defmodule RewardSystem.Repo do
  use Ecto.Repo,
    otp_app: :reward_system,
    adapter: Ecto.Adapters.Postgres
end
