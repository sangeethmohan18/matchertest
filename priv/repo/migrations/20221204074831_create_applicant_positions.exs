defmodule App.Repo.Migrations.CreateApplicantPositions do
  use Ecto.Migration

  def change do
    create table(:applicant_positions) do
      add :name, :string, null: false

      timestamps()
    end

    create index(:applicant_positions, [:name], unique: true)
  end
end
