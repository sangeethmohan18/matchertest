defmodule App.Repo.Migrations.AddApplicationFromAndPositionToApplicantDetails do
  use Ecto.Migration

  def change do
    alter table(:applicant_details) do
      add :application_from_id, references("application_routes")
      add :position_id, references("applicant_positions")
    end
  end
end
