defmodule App.Applicants.HistoryRegisterer do
  require IEx

  alias App.SelectionHistories
  alias App.Applicants
  alias App.Repo

  def execute(detail, params, admin) do
    Repo.transaction(fn ->
      history =
        params
        |> Map.put(:user_id, admin.id)
        |> SelectionHistories.insert!()

      detail
      |> Applicants.update!(%{state: history.state, step: history.step})

      history
    end)
  end
end
