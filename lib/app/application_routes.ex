defmodule App.ApplicationRoutes do
  @moduledoc """
  The ApplicationRoutes context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.ApplicationRoutes.ApplicationRoute

  use App.Record, schema: ApplicationRoute, repo: Repo

  @doc """
  Returns the list of application_routes.

  ## Examples

      iex> list_application_routes()
      [%ApplicationRoute{}, ...]

  """
  def list_application_routes do
    Repo.all(ApplicationRoute)
  end

  @doc """
  Gets a single application_route.

  Raises `Ecto.NoResultsError` if the Application route does not exist.

  ## Examples

      iex> get_application_route!(123)
      %ApplicationRoute{}

      iex> get_application_route!(456)
      ** (Ecto.NoResultsError)

  """
  def get_application_route!(id), do: Repo.get!(ApplicationRoute, id)

  @doc """
  Creates a application_route.

  ## Examples

      iex> create_application_route(%{field: value})
      {:ok, %ApplicationRoute{}}

      iex> create_application_route(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_application_route(attrs \\ %{}) do
    %ApplicationRoute{}
    |> ApplicationRoute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a application_route.

  ## Examples

      iex> update_application_route(application_route, %{field: new_value})
      {:ok, %ApplicationRoute{}}

      iex> update_application_route(application_route, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_application_route(%ApplicationRoute{} = application_route, attrs) do
    application_route
    |> ApplicationRoute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a application_route.

  ## Examples

      iex> delete_application_route(application_route)
      {:ok, %ApplicationRoute{}}

      iex> delete_application_route(application_route)
      {:error, %Ecto.Changeset{}}

  """
  def delete_application_route(%ApplicationRoute{} = application_route) do
    Repo.delete(application_route)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application_route changes.

  ## Examples

      iex> change_application_route(application_route)
      %Ecto.Changeset{data: %ApplicationRoute{}}

  """
  def change_application_route(%ApplicationRoute{} = application_route, attrs \\ %{}) do
    ApplicationRoute.changeset(application_route, attrs)
  end
end
