defmodule RewardSystem.Repo.Migrations.CreateRedemptions do
  use Ecto.Migration

  def change do
    create table(:redemptions) do
      add :points_redeemed, :integer, default: 0, null: false
      add :money_credited, :integer, default: 0, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:redemptions, [:user_id])
  end
end
