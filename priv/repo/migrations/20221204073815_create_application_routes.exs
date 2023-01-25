defmodule App.Repo.Migrations.CreateApplicationRoutes do
  use Ecto.Migration

  def change do
    create table(:application_routes) do
      add :name, :string, null: false

      timestamps()
    end

    create index(:application_routes, [:name], unique: true)
  end
end
