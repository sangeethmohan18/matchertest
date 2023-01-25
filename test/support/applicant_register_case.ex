defmodule App.ApplicantRegisterCase do
  alias App.ApplicantPositions
  alias App.ApplicationRoutes

  def create_application_route do
    ApplicationRoutes.insert!(%{name: "リファラル"})
  end

  def create_position do
    ApplicantPositions.insert!(%{name: "エンジニア"})
  end

  def current_date do
    Date.utc_today() |> Date.to_string()
  end
end
