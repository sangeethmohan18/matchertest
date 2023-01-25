defmodule AppWeb.ApplicantPositionLive.Show do
  use AppWeb, :live_view

  alias App.ApplicantPositions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:applicant_position, ApplicantPositions.get_applicant_position!(id))}
  end

  defp page_title(:show), do: "Show Applicant position"
  defp page_title(:edit), do: "Edit Applicant position"
end
