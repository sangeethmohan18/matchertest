defmodule AppWeb.ApplicantPositionLive.FormComponent do
  use AppWeb, :live_component

  alias App.ApplicantPositions.Register
  alias App.ApplicantPositions

  @impl true
  def update(%{applicant_position: applicant_position} = assigns, socket) do
    changeset = ApplicantPositions.change_applicant_position(applicant_position)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"applicant_position" => applicant_position_params}, socket) do
    changeset =
      socket.assigns.applicant_position
      |> ApplicantPositions.change_applicant_position(applicant_position_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"applicant_position" => applicant_position_params}, socket) do
    save_applicant_position(socket, socket.assigns.action, applicant_position_params)
  end

  defp save_applicant_position(socket, :edit, applicant_position_params) do
    case ApplicantPositions.update_applicant_position(
           socket.assigns.applicant_position,
           applicant_position_params
         ) do
      {:ok, _applicant_position} ->
        {:noreply,
         socket
         |> put_flash(:info, "募集ポジションを更新しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_applicant_position(socket, :new, applicant_position_params) do
    case ApplicantPositions.create_applicant_position(applicant_position_params) do
      {:ok, _applicant_position} ->
        {:noreply,
         socket
         |> put_flash(:info, "募集ポジションを登録しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
