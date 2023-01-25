defmodule App.ApplicantPositionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.ApplicantPositions` context.
  """

  @doc """
  Generate a applicant_position.
  """
  def applicant_position_fixture(attrs \\ %{}) do
    {:ok, applicant_position} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> App.ApplicantPositions.create_applicant_position()

    applicant_position
  end
end
