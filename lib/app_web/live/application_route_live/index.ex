defmodule AppWeb.ApplicationRouteLive.Index do
  use AppWeb, :live_view

  alias App.ApplicationRoutes
  alias App.ApplicationRoutes.ApplicationRoute

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:application_routes, list_application_routes())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "応募経路を編集")
    |> assign(:application_route, ApplicationRoutes.get_application_route!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "応募経路を登録")
    |> assign(:application_route, %ApplicationRoute{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Application routes")
    |> assign(:application_route, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    application_route = ApplicationRoutes.get_application_route!(id)
    {:ok, _} = ApplicationRoutes.delete_application_route(application_route)

    {:noreply, assign(socket, :application_routes, list_application_routes())}
  end

  defp list_application_routes do
    ApplicationRoutes.list_application_routes()
  end
end
