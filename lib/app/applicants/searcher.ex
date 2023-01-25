defmodule App.Searcher do
  require IEx

  alias App.ApplicationRoutes
  alias App.ApplicantPositions
  alias App.Applicants

  def execute(query) do
    query
    |> parse_query()
    |> Applicants.search_with()
  end

  def parse_query(q) do
    q
    |> String.split(~r/( |　)/)
    |> Enum.map(&(&1 |> String.split(":") |> parse_q()))
    |> reduce_duplicated_q()
    |> Enum.reject(fn map -> map |> Map.values() |> List.first() == "" end)
    |> order_query()
  end

  def order_query(q) do
    q
    |> Enum.reduce(%{}, fn query, acm ->
      key = query |> Map.keys() |> List.first()
      val = Map.get(query, key)

      acm_val = Map.get(acm, key)

      if acm_val do
        %{acm | key => acm_val ++ [val]}
      else
        Map.put(acm, key, [val])
      end
    end)
  end

  def reduce_duplicated_q(q) do
    Enum.reduce(q, [], fn query, acm ->
      if duped_any?(acm, query) do
        acm
      else
        acm ++ [query]
      end
    end)
  end

  defp duped_any?(acm, query), do: Enum.any?(acm, &(&1 == query))
  defp parse_q([str]), do: %{text: str}
  defp parse_q(["ステータス", value]), do: %{state: convert_state_value(value)}
  defp parse_q(["ステップ", value]), do: %{step: convert_step_value(value)}
  defp parse_q([key, value]), do: %{convert_query_key(key) => value}
  defp convert_query_key("経路"), do: :route
  defp convert_query_key("ポジション"), do: :position
  defp convert_query_key("ステータス"), do: :state
  defp convert_query_key("ステップ"), do: :step

  defp convert_state_value(value),
    do: Applicants.reverse_translate_state(value) |> Atom.to_string()

  defp convert_step_value(value), do: Applicants.reverse_translate_step(value) |> Atom.to_string()
end
