defmodule App.Repo.Migrations.CreateApplicantSelectionHistories do
  use Ecto.Migration

  def change do
    create table(:applicant_selection_histories) do
      add :state, :string
      add :step, :string
      add :comment, :text
      add :applicant_detail_id, references(:applicant_details, on_delete: :nothing)

      timestamps()
    end

    create index(:applicant_selection_histories, [:applicant_detail_id])
  end
end
