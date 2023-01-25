defmodule App.Repo.Migrations.AddStateAndStepToApplicants do
  use Ecto.Migration

  def change do
    alter table(:applicant_details) do
      add :state, :string, null: false, default: "application"
      add :step, :string, null: false, default: "application"
    end

    create index(:applicant_details, [:state])
    create index(:applicant_details, [:step])
  end
end
