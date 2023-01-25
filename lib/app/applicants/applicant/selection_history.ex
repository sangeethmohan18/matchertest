defmodule App.Applicants.Applicant.SelectionHistory do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Applicants.Applicant.Detail
  alias App.Admins.User

  schema "applicant_selection_histories" do
    field :comment, :string
    field :step, :string
    field :state, :string
    belongs_to :applicant_detail, Detail, foreign_key: :applicant_detail_id
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(selection_history, attrs) do
    selection_history
    |> cast(attrs, [:state, :step, :comment, :applicant_detail_id, :user_id])
    |> validate_required([:state, :step, :applicant_detail_id, :user_id])
  end
end
