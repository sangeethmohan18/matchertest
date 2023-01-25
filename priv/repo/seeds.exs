# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

App.Repo.transaction(fn ->
  App.ApplicationRoutes.insert_all([
    %{name: "リファラル"},
    %{name: "Doda"},
    %{name: "Green"}
  ])

  App.ApplicantPositions.insert_all([
    %{name: "エンジニア(バックエンド)"},
    %{name: "エンジニア(インフラ)"},
    %{name: "エンジニア(フロントエンド)"},
    %{name: "エンジニア(Blockchain)"}
  ])
end)

ExAws.S3.put_bucket("matcher", "local")
|> ExAws.request()
