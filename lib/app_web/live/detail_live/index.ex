defmodule AppWeb.DetailLive.Index do
  require IEx

  use AppWeb, :live_view

  alias App.Applicants
  alias App.Admins
  alias App.Applicants.Applicant.Detail
  alias App.Searcher

  @impl true
  def mount(_params, session, socket) do
    {
      :ok,
      socket
      |> assign(:applicant_details, list_applicant_details())
      |> assign(:current_user, Admins.get_user_by_session_token(session["user_token"]))
      |> assign(:query, :query)
    }
  end

  @impl true
  def handle_event("search", %{"query" => %{"query" => query}}, socket) do
    {
      :noreply,
      socket
      |> assign(:applicant_details, Searcher.execute(query))
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:current_user, socket.assigns.current_user)
    |> assign(:page_title, "Edit Detail")
    |> assign(:detail, Applicants.get_detail!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "応募者を登録")
    |> assign(:detail, %Detail{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:current_user, socket.assigns.current_user)
    |> assign(:page_title, "Listing Applicant details")
    |> assign(:detail, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    detail = Applicants.get_detail!(id)
    {:ok, _} = Applicants.delete_detail(detail)

    {:noreply, assign(socket, :applicant_details, list_applicant_details())}
  end

  defp list_applicant_details do
    Applicants.all()
    |> Applicants.preload([:position, :application_from, :histories])
  end

  def search_applicant_details(query) do
    Applicants.search(query)
  end
end
