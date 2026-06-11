defmodule RewardSystem.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :activity_type, :string, null: false
      add :points, :integer, default: 0, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:rewards, [:user_id])
  end
end
