defmodule App.Repo.Migrations.CreateApplicantDetails do
  use Ecto.Migration

  def change do
    create table(:applicant_details) do
      add :name, :string, null: false
      add :name_kana, :string
      add :email, :string
      add :phone_number, :string
      add :applied_on, :date, null: false

      timestamps()
    end

    create index(:applicant_details, [:name])
  end
end
