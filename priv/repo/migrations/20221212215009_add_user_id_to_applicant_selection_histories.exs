defmodule App.Repo.Migrations.AddUserIdToApplicantSelectionHistories do
  use Ecto.Migration

  def change do
    alter table(:applicant_selection_histories) do
      add :user_id, references("users")
    end
  end
end
