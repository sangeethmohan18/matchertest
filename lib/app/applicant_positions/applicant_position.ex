defmodule App.ApplicantPositions.ApplicantPosition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applicant_positions" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(applicant_position, attrs) do
    applicant_position
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
