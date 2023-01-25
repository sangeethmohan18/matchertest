defmodule App.ApplicantsTest do
  use App.DataCase

  alias App.Applicants
  alias App.ApplicantRegisterCase

  describe "applicant_details" do
    alias App.Applicants.Applicant.Detail

    import App.ApplicantsFixtures

    @invalid_attrs %{email: nil, name: nil, name_kana: nil, phone_number: nil}

    test "list_applicant_details/0 returns all applicant_details" do
      detail = detail_fixture()
      assert Applicants.list_applicant_details() == [detail]
    end

    test "get_detail!/1 returns the detail with given id" do
      detail = detail_fixture()
      assert Applicants.get_detail!(detail.id) == detail
    end

    test "create_detail/1 with valid data creates a detail" do
      position = ApplicantRegisterCase.create_position()
      route = ApplicantRegisterCase.create_application_route()

      valid_attrs = %{
        email: "some email",
        name: "some name",
        name_kana: "some name_kana",
        phone_number: "some phone_number",
        applied_on: ApplicantRegisterCase.current_date(),
        position_id: position.id,
        application_from_id: route.id
      }

      assert {:ok, %Detail{} = detail} = Applicants.create_detail(valid_attrs)
      assert detail.email == "some email"
      assert detail.name == "some name"
      assert detail.name_kana == "some name_kana"
      assert detail.phone_number == "some phone_number"
    end

    test "create_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applicants.create_detail(@invalid_attrs)
    end

    test "update_detail/2 with valid data updates the detail" do
      detail = detail_fixture()

      update_attrs = %{
        email: "some updated email",
        name: "some updated name",
        name_kana: "some updated name_kana",
        phone_number: "some updated phone_number"
      }

      assert {:ok, %Detail{} = detail} = Applicants.update_detail(detail, update_attrs)
      assert detail.email == "some updated email"
      assert detail.name == "some updated name"
      assert detail.name_kana == "some updated name_kana"
      assert detail.phone_number == "some updated phone_number"
    end

    test "update_detail/2 with invalid data returns error changeset" do
      detail = detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Applicants.update_detail(detail, @invalid_attrs)
      assert detail == Applicants.get_detail!(detail.id)
    end

    test "delete_detail/1 deletes the detail" do
      detail = detail_fixture()
      assert {:ok, %Detail{}} = Applicants.delete_detail(detail)
      assert_raise Ecto.NoResultsError, fn -> Applicants.get_detail!(detail.id) end
    end

    test "change_detail/1 returns a detail changeset" do
      detail = detail_fixture()
      assert %Ecto.Changeset{} = Applicants.change_detail(detail)
    end
  end
end
