defmodule AppWeb.ApplicationRouteLive.Show do
  use AppWeb, :live_view

  alias App.ApplicationRoutes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:application_route, ApplicationRoutes.get_application_route!(id))}
  end

  defp page_title(:show), do: "Show Application route"
  defp page_title(:edit), do: "Edit Application route"
end
