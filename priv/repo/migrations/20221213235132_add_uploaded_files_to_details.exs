defmodule App.Repo.Migrations.AddUploadedFilesToDetails do
  use Ecto.Migration

  def change do
    alter table(:applicant_details) do
      add :uploaded_files, :string
    end
  end
end
