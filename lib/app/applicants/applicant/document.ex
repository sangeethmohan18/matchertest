defmodule App.Applicants.Applicant.Document do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.Applicants.Applicant.Detail

  schema "applicant_documents" do
    field :active, :boolean, default: false
    field :mimetype, :string
    field :path, :string
    belongs_to :applicant_detail, Detail, foreign_key: :applicant_detail_id

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:path, :mimetype, :active, :applicant_detail_id])
    |> validate_required([:path, :mimetype, :active, :applicant_detail_id])
  end
end
