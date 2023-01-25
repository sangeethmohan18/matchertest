defmodule App.Repo.Migrations.CreateApplicantDocuments do
  use Ecto.Migration

  def change do
    create table(:applicant_documents) do
      add :path, :text, null: false
      add :mimetype, :string, null: false
      add :active, :boolean, default: false, null: false
      add :applicant_detail_id, references(:applicant_details, on_delete: :nothing)

      timestamps()
    end

    create index(:applicant_documents, [:applicant_detail_id])
  end
end
