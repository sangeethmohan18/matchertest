defmodule App.Applicants.Registerer do
  require IEx

  alias App.Repo
  alias App.Applicants
  alias App.SelectionHistories
  alias App.Storage.Bucket
  alias App.ApplicantDocuments
  alias App.Applicants.DocumentUploader

  def execute(detail_params, admin, uploaded_files) do
    Repo.transaction(fn ->
      applicant = Applicants.create!(detail_params)
      SelectionHistories.create!(build_default_state_params(applicant, admin))
      DocumentUploader.execute(uploaded_files, applicant)

      applicant |> Repo.preload([:histories, :documents, :position, :application_from])
    end)
  end

  defp build_default_state_params(applicant, admin) do
    %{
      step: "application",
      state: "application",
      applicant_detail_id: applicant.id,
      user_id: admin.id
    }
  end
end
