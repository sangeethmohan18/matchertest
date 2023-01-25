defmodule App.ApplicantDocuments do
  @moduledoc """
  The Applicant.State context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Applicants.Applicant.Document

  use App.Record, schema: Document, repo: Repo
end
