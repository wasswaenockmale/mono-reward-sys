defmodule RewardSystem.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :points, :integer, default: 0, null: false
      add :wallet_balance, :integer, default: 0, null: false
      add :hashed_password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
