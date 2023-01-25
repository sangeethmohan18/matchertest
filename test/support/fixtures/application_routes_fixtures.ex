defmodule App.ApplicationRoutesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.ApplicationRoutes` context.
  """

  @doc """
  Generate a application_route.
  """
  def application_route_fixture(attrs \\ %{}) do
    {:ok, application_route} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> App.ApplicationRoutes.create_application_route()

    application_route
  end
end
