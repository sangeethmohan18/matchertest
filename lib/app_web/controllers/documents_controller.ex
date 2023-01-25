defmodule AppWeb.DocumentsController do
  use AppWeb, :controller

  alias App.Storage.Bucket
  require IEx

  def show(conn, %{"id" => _id}) do
    path =
      "uploads/user/documents/2/original-b3JpZ2luYWwtY0dWeVptVmpkQzVxY0djLmpwZw/original-cGVyZmVjdC5qcGc.jpg"

    dest = "tmp/#{Ecto.UUID.generate()}-#{Path.basename(path)}"
    {:ok, :done} = Bucket.download(path, dest)

    file = File.read!(dest)
    mimetype = MIME.from_path(dest)

    conn
    |> put_resp_content_type(mimetype)
    |> put_resp_header("content-disposition", "attachment; filename=\"#{Path.basename(dest)}\"")
    |> put_root_layout(false)
    |> send_resp(200, File.read!(dest))
  end
end
