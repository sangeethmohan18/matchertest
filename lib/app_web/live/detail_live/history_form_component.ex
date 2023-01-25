defmodule AppWeb.DetailLive.HistoryFormComponent do
  use AppWeb, :live_component

  alias App.Applicants
  alias App.Applicants.Registerer
  alias App.Applicants.HistoryRegisterer
  alias App.ApplicantPositions
  alias App.ApplicationRoutes
  alias App.SelectionHistories

  require IEx

  def __live__(_), do: nil

  def update(assigns, socket) do
    detail = Applicants.find(assigns.id)
    history = assigns.history
    changeset = SelectionHistories.changeset(history, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:states, set_states())
     |> assign(:steps, set_steps())
     |> assign(:history, history)
     |> assign(:changeset, changeset)
     |> assign(:detail, detail)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    history =
      prepare_history_params(socket, params)
      |> SelectionHistories.new()

    changeset = SelectionHistories.changeset(history, %{})

    {:noreply,
     assign(socket, :changeset, changeset)
     |> assign(:history, history)}
  end

  def handle_event("save", params, socket) do
    history_params = prepare_history_params(socket, params)
    save_history(socket, history_params)
  end

  defp save_history(socket, params) do
    detail = Applicants.find(socket.assigns.id)

    case HistoryRegisterer.execute(detail, params, socket.assigns.current_user) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "選考情報を更新しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp prepare_history_params(socket, params) do
    params
    |> Map.delete("_target")
    |> Map.put("applicant_detail_id", socket.assigns.detail.id)
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end

  defp set_changeset(socket, history_params) do
    socket.assigns.history
    |> SelectionHistories.changeset(history_params)
    |> Map.put(:action, :validate)
  end

  defp set_history(params), do: SelectionHistories.new(params)

  defp set_states, do: Applicants.states()
  defp set_steps, do: Applicants.steps()
end
