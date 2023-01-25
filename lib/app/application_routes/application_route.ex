defmodule App.ApplicationRoutes.ApplicationRoute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "application_routes" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(application_route, attrs) do
    application_route
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
