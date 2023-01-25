defmodule App.Repo.Migrations.AddCurrentStepToApplicantStates do
  use Ecto.Migration

  def change do
    alter table(:applicant_states) do
      add :current_step, :string, null: false
    end
  end
end
