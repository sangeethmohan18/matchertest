defmodule App.SelectionHistories do
  @moduledoc """
  The Applicant.State context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Applicants.Applicant.SelectionHistory

  use App.Record, schema: SelectionHistory, repo: Repo
end
