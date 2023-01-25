defmodule AppWeb.ApplicationRouteLive.FormComponent do
  use AppWeb, :live_component

  alias App.ApplicationRoutes

  @impl true
  def update(%{application_route: application_route} = assigns, socket) do
    changeset = ApplicationRoutes.change_application_route(application_route)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"application_route" => application_route_params}, socket) do
    changeset =
      socket.assigns.application_route
      |> ApplicationRoutes.change_application_route(application_route_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"application_route" => application_route_params}, socket) do
    save_application_route(socket, socket.assigns.action, application_route_params)
  end

  defp save_application_route(socket, :edit, application_route_params) do
    case ApplicationRoutes.update_application_route(
           socket.assigns.application_route,
           application_route_params
         ) do
      {:ok, _application_route} ->
        {:noreply,
         socket
         |> put_flash(:info, "応募経路を更新しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_application_route(socket, :new, application_route_params) do
    case ApplicationRoutes.create_application_route(application_route_params) do
      {:ok, _application_route} ->
        {:noreply,
         socket
         |> put_flash(:info, "応募経路を登録しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
