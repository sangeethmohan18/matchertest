defmodule App.ApplicantPositionsTest do
  use App.DataCase

  alias App.ApplicantPositions

  describe "applicant_positions" do
    alias App.ApplicantPositions.ApplicantPosition

    import App.ApplicantPositionsFixtures

    @invalid_attrs %{name: nil}

    test "list_applicant_positions/0 returns all applicant_positions" do
      applicant_position = applicant_position_fixture()
      assert ApplicantPositions.list_applicant_positions() == [applicant_position]
    end

    test "get_applicant_position!/1 returns the applicant_position with given id" do
      applicant_position = applicant_position_fixture()
      assert ApplicantPositions.get_applicant_position!(applicant_position.id) == applicant_position
    end

    test "create_applicant_position/1 with valid data creates a applicant_position" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %ApplicantPosition{} = applicant_position} = ApplicantPositions.create_applicant_position(valid_attrs)
      assert applicant_position.name == "some name"
    end

    test "create_applicant_position/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApplicantPositions.create_applicant_position(@invalid_attrs)
    end

    test "update_applicant_position/2 with valid data updates the applicant_position" do
      applicant_position = applicant_position_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %ApplicantPosition{} = applicant_position} = ApplicantPositions.update_applicant_position(applicant_position, update_attrs)
      assert applicant_position.name == "some updated name"
    end

    test "update_applicant_position/2 with invalid data returns error changeset" do
      applicant_position = applicant_position_fixture()
      assert {:error, %Ecto.Changeset{}} = ApplicantPositions.update_applicant_position(applicant_position, @invalid_attrs)
      assert applicant_position == ApplicantPositions.get_applicant_position!(applicant_position.id)
    end

    test "delete_applicant_position/1 deletes the applicant_position" do
      applicant_position = applicant_position_fixture()
      assert {:ok, %ApplicantPosition{}} = ApplicantPositions.delete_applicant_position(applicant_position)
      assert_raise Ecto.NoResultsError, fn -> ApplicantPositions.get_applicant_position!(applicant_position.id) end
    end

    test "change_applicant_position/1 returns a applicant_position changeset" do
      applicant_position = applicant_position_fixture()
      assert %Ecto.Changeset{} = ApplicantPositions.change_applicant_position(applicant_position)
    end
  end
end
