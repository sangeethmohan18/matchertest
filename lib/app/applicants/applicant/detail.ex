defmodule App.Applicants.Applicant.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.ApplicationRoutes.ApplicationRoute
  alias App.ApplicantPositions.ApplicantPosition
  alias App.Applicants.Applicant.SelectionHistory
  alias App.Applicants.Applicant.Document

  schema "applicant_details" do
    field :email, :string
    field :name, :string
    field :name_kana, :string
    field :phone_number, :string
    field :applied_on, :date
    field :state, :string, default: "application"
    field :step, :string, default: "application"
    field :uploaded_files, :string
    belongs_to :application_from, ApplicationRoute
    belongs_to :position, ApplicantPosition
    has_many :histories, SelectionHistory, foreign_key: :applicant_detail_id
    has_many :documents, Document, foreign_key: :applicant_detail_id

    timestamps()
  end

  require IEx

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, [
      :name,
      :name_kana,
      :email,
      :phone_number,
      :applied_on,
      :position_id,
      :application_from_id,
      :state,
      :step,
      :uploaded_files
    ])
    |> validate_required([:name, :applied_on, :position_id, :application_from_id, :state, :step])
  end
end
