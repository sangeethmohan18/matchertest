defmodule AppWeb.ApplicantPositionLive.Index do
  use AppWeb, :live_view

  alias App.ApplicantPositions
  alias App.ApplicantPositions.ApplicantPosition

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:applicant_positions, list_applicant_positions())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "ポジションを編集")
    |> assign(:applicant_position, ApplicantPositions.get_applicant_position!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "ポジションを登録")
    |> assign(:applicant_position, %ApplicantPosition{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Applicant positions")
    |> assign(:applicant_position, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    applicant_position = ApplicantPositions.get_applicant_position!(id)
    {:ok, _} = ApplicantPositions.delete_applicant_position(applicant_position)

    {:noreply, assign(socket, :applicant_positions, list_applicant_positions())}
  end

  defp list_applicant_positions do
    ApplicantPositions.list_applicant_positions()
  end
end
