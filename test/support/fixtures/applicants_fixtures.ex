defmodule App.ApplicantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Applicants` context.
  """

  @doc """
  Generate a detail.
  """

  require IEx

  alias App.ApplicantRegisterCase

  def detail_fixture(attrs \\ %{}) do
    position = ApplicantRegisterCase.create_position()
    route = ApplicantRegisterCase.create_application_route()

    {:ok, detail} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        name_kana: "some name_kana",
        phone_number: "some phone_number",
        applied_on: Date.utc_today(),
        position_id: position.id,
        application_from_id: route.id
      })
      |> App.Applicants.create_detail()

    detail
  end
end
