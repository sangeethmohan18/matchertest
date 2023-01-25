defmodule App.Storage.Bucket do
  require Logger
  require IEx

  alias ExAws.S3
  alias App.Documents

  def upload(file_path, scope) do
    {:ok, f} = Documents.store({file_path, scope})
    f
  end

  def download(f, scope) do
    # NOTE: ローカル(Docker)開発時、アップロードしたファイルが閲覧できない問題が発生する
    # この問題はminioのホストがminio:9000となっていることに起因する
    # localhost:9000とすればアクセスできるが、左記の対応を行うとファイルアップロードができなくなる
    # Dockerでのローカル開発は止めたほうが良いかも知れない
    Documents.url({f, scope}, signed: true)
  end

  defp bucket, do: "matcher"
end
