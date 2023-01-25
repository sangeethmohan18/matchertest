defmodule AppWeb.DetailLive.FormComponent do
  use AppWeb, :live_component

  alias App.Applicants
  alias App.Applicants.Registerer
  alias App.ApplicantPositions
  alias App.ApplicationRoutes
  alias App.Applicants.DocumentUploader

  require IEx

  @impl true
  def update(%{detail: detail} = assigns, socket) do
    changeset = Applicants.change_detail(detail)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:positions, fetch_positions)
     |> assign(:routes, fetch_routes)
     |> assign(:changeset, changeset)
     |> allow_upload(:uploaded_files,
       accept: ~w(.jpg .jpeg .png .pdf .mp4),
       max_entries: 5
     )}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    IEx.pry()
    {:noreply, cancel_upload(socket, :uploaded_files, ref)}
  end

  @impl true
  def handle_event("validate", %{"detail" => detail_params}, socket) do
    changeset =
      socket.assigns.detail
      |> Applicants.change_detail(detail_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"detail" => detail_params} = params, socket) do
    save_detail(socket, socket.assigns.action, detail_params)
  end

  defp save_detail(socket, :edit, detail_params) do
    case Applicants.update_detail(socket.assigns.detail, detail_params) do
      {:ok, applicant} ->
        consume_uploaded_entries(socket, :uploaded_files, fn %{path: path}, entry ->
          dest = Path.join("tmp", "#{Path.basename(path)}#{Path.extname(entry.client_name)}")
          File.cp!(path, dest)
          %{path: path, entry: entry, dest: dest}
        end)
        |> DocumentUploader.execute(applicant)

        {:noreply,
         socket
         |> put_flash(:info, "応募者情報を更新しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_detail(socket, :new, detail_params) do
    uploaded_files =
      consume_uploaded_entries(socket, :uploaded_files, fn %{path: path}, entry ->
        dest = Path.join("tmp", "#{Path.basename(path)}#{Path.extname(entry.client_name)}")
        File.cp!(path, dest)
        %{path: path, entry: entry, dest: dest}
      end)

    case Registerer.execute(detail_params, socket.assigns.current_user, uploaded_files) do
      {:ok, _detail} ->
        {:noreply,
         socket
         |> put_flash(:info, "応募者情報を登録しました")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp fetch_positions do
    ApplicantPositions.all()
    |> Enum.map(fn position ->
      {:"#{position.name}", position.id}
    end)
  end

  defp fetch_routes do
    ApplicationRoutes.all()
    |> Enum.map(fn route ->
      {:"#{route.name}", route.id}
    end)
  end
end
