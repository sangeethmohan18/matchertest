defmodule App.Applicants do
  require IEx

  @moduledoc """
  The Applicants context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Applicants.Applicant.Detail

  use App.Record, schema: Detail, repo: Repo

  def search_with(conds) do
    build_nope_query()
    |> build_query_with_name(conds)
    |> build_query_with_name_kana(conds)
    |> build_query_with_states(conds)
    |> build_query_with_steps(conds)
    |> search()
  end

  defp build_nope_query, do: dynamic([t], t.id == 0)

  defp build_query_with_name(query, %{text: text}) do
    text
    |> Enum.reduce(query, fn text, acm ->
      dynamic([t], like(t.name, ^"%#{text}%") or ^acm)
    end)
  end

  defp build_query_with_name(query, _), do: query

  defp build_query_with_name_kana(query, %{text: text}) do
    text
    |> Enum.reduce(query, fn text, acm ->
      dynamic([t], like(t.name_kana, ^"%#{text}%") or ^acm)
    end)
  end

  defp build_query_with_name_kana(query, _), do: query

  defp build_query_with_states(query, %{state: state}),
    do: dynamic([t], t.state in ^state or ^query)

  defp build_query_with_states(query, _), do: query
  defp build_query_with_steps(query, %{step: step}), do: dynamic([t], t.step in ^step or ^query)
  defp build_query_with_steps(query, _), do: query

  def search(query) do
    Detail
    |> join(:left, [t], routes in assoc(t, :position))
    |> join(:left, [t], positions in assoc(t, :application_from))
    |> where(^query)
    |> Repo.all()
    |> Repo.preload([:position, :application_from, :histories])
  end

  def states do
    [
      application: "応募",
      selectioning: "選考中",
      acceptance: "採用",
      rejected: "不採用",
      declination: "辞退"
    ]
  end

  def reverse_translate_state(value) do
    states()
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Enum.into(%{})
    |> Map.get(value)
  end

  def reverse_translate_step(value) do
    steps()
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Enum.into(%{})
    |> Map.get(value)
  end

  def translate_state(key) when is_bitstring(key) do
    key
    |> String.to_atom()
    |> translate_state()
  end

  def translate_state(key), do: states() |> Keyword.fetch!(key)

  def steps do
    [
      application: "応募",
      document_screening: "書類選考",
      task_screening: "課題選考",
      surgery: "面談",
      first_interview: "1次面接",
      manager_interview: "部長面接",
      president_interview: "社長面接"
    ]
  end

  def translate_step(key) when is_bitstring(key) do
    key
    |> String.to_atom()
    |> translate_step()
  end

  def translate_step(key), do: steps |> Keyword.fetch!(key)

  def update_step!(detail, next_step) do
    detail
    |> update!(%{step: next_step})
  end

  @doc """
  Returns the list of applicant_details.

  ## Examples

      iex> list_applicant_details()
      [%Detail{}, ...]

  """
  def list_applicant_details do
    Repo.all(Detail)
  end

  @doc """
  Gets a single detail.

  Raises `Ecto.NoResultsError` if the Detail does not exist.

  ## Examples

      iex> get_detail!(123)
      %Detail{}

      iex> get_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_detail!(id), do: Repo.get!(Detail, id)

  @doc """
  Creates a detail.

  ## Examples

      iex> create_detail(%{field: value})
      {:ok, %Detail{}}

      iex> create_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_detail(attrs \\ %{}) do
    %Detail{}
    |> Detail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a detail.

  ## Examples

      iex> update_detail(detail, %{field: new_value})
      {:ok, %Detail{}}

      iex> update_detail(detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_detail(%Detail{} = detail, attrs) do
    detail
    |> Detail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a detail.

  ## Examples

      iex> delete_detail(detail)
      {:ok, %Detail{}}

      iex> delete_detail(detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_detail(%Detail{} = detail) do
    Repo.delete(detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking detail changes.

  ## Examples

      iex> change_detail(detail)
      %Ecto.Changeset{data: %Detail{}}

  """
  def change_detail(%Detail{} = detail, attrs \\ %{}) do
    Detail.changeset(detail, attrs)
  end
end
