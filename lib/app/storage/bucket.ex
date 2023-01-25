defmodule App.Storage.Bucket do
  require Logger
  # use ExAws.S3.Client, otp_app: :app
  #
  # def create() do
  #   put_bucket("fuga", "us-east-0")
  #   put_object("fuga", "name", "aaa")
  # end

  require IEx

  alias ExAws.S3
  alias App.Documents

  def upload(file_path, scope) do
    {:ok, f} = Documents.store({file_path, scope})
    f
  end

  def download(f, scope) do
    Documents.url({f, scope}, signed: true)
  end

  defp bucket, do: "matcher"
end
