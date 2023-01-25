defmodule App.Applicants.DocumentUploader do
  alias App.Storage.Bucket
  alias App.ApplicantDocuments

  def execute(files, applicant) do
    files
    |> Enum.map(fn file ->
      upload_file!(file, applicant)
    end)
    |> Enum.map(fn {file, f} ->
      %{
        active: true,
        mimetype: file.entry.client_type,
        path: f,
        applicant_detail_id: applicant.id
      }
    end)
    |> ApplicantDocuments.insert_all()
  end

  defp upload_file!(file, scope) do
    f = Bucket.upload(file.dest, scope)
    {file, f}
  end
end
