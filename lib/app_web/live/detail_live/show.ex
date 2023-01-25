defmodule AppWeb.DetailLive.Show do
  use AppWeb, :live_view
  require IEx

  alias App.Applicants
  alias App.Admins
  alias App.SelectionHistories
  alias App.Applicants.Applicant.SelectionHistory
  alias App.ApplicantDocuments

  @impl true
  def mount(_params, session, socket) do
    {
      :ok,
      socket
      |> assign(:current_user, Admins.get_user_by_session_token(session["user_token"]))
    }
  end

  def handle_event("remove-doc", %{"id" => id}, socket) do
    id
    |> ApplicantDocuments.find()
    |> ApplicantDocuments.delete()

    {:noreply,
     socket
     |> assign(:detail, fetch_detail(socket.assigns.detail.id))}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    detail = fetch_detail(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:detail, detail)
     |> assign(:histories, fetch_histories_by(detail))
     |> assign(:new_history, %SelectionHistory{})}
  end

  defp fetch_histories_by(detail) do
    detail.histories
    |> Enum.sort_by(& &1.inserted_at)
    |> Enum.reverse()
  end

  defp fetch_detail(id) do
    Applicants.find(id)
    |> Applicants.preload([:application_from, :documents, :position, histories: :user])
  end

  defp page_title(:show), do: "Show Detail"
  defp page_title(:edit), do: "Edit Detail"
  defp page_title(:history), do: "History Detail"
end
