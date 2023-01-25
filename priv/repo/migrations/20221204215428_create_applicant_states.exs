defmodule App.Repo.Migrations.CreateApplicantStates do
  use Ecto.Migration

  def change do
    create table(:applicant_states) do
      add :current_state, :string, null: false
      add :comment, :string
      add :applicant_detail_id, references(:applicant_details, on_delete: :nothing)

      timestamps()
    end

    create index(:applicant_states, [:applicant_detail_id])
  end
end
