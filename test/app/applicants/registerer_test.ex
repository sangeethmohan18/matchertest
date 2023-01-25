defmodule App.Applicants.RegistererTest do
  use App.DataCase

  alias App.Applicants.Registerer
  alias App.Applicants
  alias App.ApplicantStates
  alias App.ApplicantRegisterCase

  describe "applicant register" do
    require IEx

    test "応募者を登録できる" do
      route = ApplicantRegisterCase.create_application_route()
      position = ApplicantRegisterCase.create_position()

      params = %{
        name: "hoge",
        name_kana: "ホゲ",
        email: "test@example.com",
        phone_number: "000-0000-6666",
        applied_on: ApplicantRegisterCase.current_date(),
        position_id: position.id,
        application_from_id: route.id
      }

      {:ok, applicant} = Registerer.execute(params)
      assert applicant.name == params.name
      assert applicant.name_kana == params.name_kana
      assert applicant.email == params.email
      assert applicant.phone_number == params.phone_number

      assert applicant.position.name == position.name
      assert applicant.application_from.name == route.name

      assert (applicant.states |> List.first()).current_step == "application"
      assert (applicant.states |> List.first()).current_state == "application"
    end
  end

  describe "登録に失敗した場合" do
    test "必須パラメータが無い" do
      route = ApplicantRegisterCase.create_application_route()
      position = ApplicantRegisterCase.create_position()

      assert_raise(Ecto.InvalidChangesetError, fn ->
        Registerer.execute(%{
          name: nil,
          name_kana: "ホゲ",
          email: "test@example.com",
          phone_number: "000-0000-6666",
          applied_on: ApplicantRegisterCase.current_date(),
          position_id: position.id,
          application_from_id: route.id
        })
      end)

      assert_raise(Ecto.InvalidChangesetError, fn ->
        Registerer.execute(%{
          name: "ほげ",
          name_kana: "ホゲ",
          email: "test@example.com",
          phone_number: "000-0000-6666",
          applied_on: nil,
          position_id: position.id,
          application_from_id: route.id
        })
      end)

      assert_raise(Ecto.InvalidChangesetError, fn ->
        Registerer.execute(%{
          name: "ほげ",
          name_kana: "ホゲ",
          email: "test@example.com",
          phone_number: "000-0000-6666",
          applied_on: ApplicantRegisterCase.current_date(),
          position_id: nil,
          application_from_id: nil
        })
      end)

      assert Applicants.all() |> length() == 0
      assert ApplicantStates.all() |> length() == 0
    end
  end
end
