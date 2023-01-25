defmodule App.ApplicantPositions do
  @moduledoc """
  The ApplicantPositions context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.ApplicantPositions.ApplicantPosition

  use App.Record, schema: ApplicantPosition, repo: Repo

  @doc """
  Returns the list of applicant_positions.

  ## Examples

      iex> list_applicant_positions()
      [%ApplicantPosition{}, ...]

  """
  def list_applicant_positions do
    Repo.all(ApplicantPosition)
  end

  @doc """
  Gets a single applicant_position.

  Raises `Ecto.NoResultsError` if the Applicant position does not exist.

  ## Examples

      iex> get_applicant_position!(123)
      %ApplicantPosition{}

      iex> get_applicant_position!(456)
      ** (Ecto.NoResultsError)

  """
  def get_applicant_position!(id), do: Repo.get!(ApplicantPosition, id)

  @doc """
  Creates a applicant_position.

  ## Examples

      iex> create_applicant_position(%{field: value})
      {:ok, %ApplicantPosition{}}

      iex> create_applicant_position(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_applicant_position(attrs \\ %{}) do
    %ApplicantPosition{}
    |> ApplicantPosition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a applicant_position.

  ## Examples

      iex> update_applicant_position(applicant_position, %{field: new_value})
      {:ok, %ApplicantPosition{}}

      iex> update_applicant_position(applicant_position, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_applicant_position(%ApplicantPosition{} = applicant_position, attrs) do
    applicant_position
    |> ApplicantPosition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a applicant_position.

  ## Examples

      iex> delete_applicant_position(applicant_position)
      {:ok, %ApplicantPosition{}}

      iex> delete_applicant_position(applicant_position)
      {:error, %Ecto.Changeset{}}

  """
  def delete_applicant_position(%ApplicantPosition{} = applicant_position) do
    Repo.delete(applicant_position)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking applicant_position changes.

  ## Examples

      iex> change_applicant_position(applicant_position)
      %Ecto.Changeset{data: %ApplicantPosition{}}

  """
  def change_applicant_position(%ApplicantPosition{} = applicant_position, attrs \\ %{}) do
    ApplicantPosition.changeset(applicant_position, attrs)
  end
end
