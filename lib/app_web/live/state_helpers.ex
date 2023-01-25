defmodule AppWeb.StateHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  def current_step("application"), do: "応募"
  def current_step("document_screening"), do: "書類選考"
  def current_step("task_screening"), do: "課題選考"
  def current_step("surgery"), do: "面談"
  def current_step("first_interview"), do: "一次面接"
  def current_step("manager_interview"), do: "部門長面接"
  def current_step("president_interview"), do: "社長"
  def current_step(state), do: state

  def current_state("application"), do: "応募 📄"
  def current_state("selectioning"), do: "選考中 🤔"
  def current_state("acceptance"), do: "採用 🎉"
  def current_state("rejected"), do: "不採用 😩"
  def current_state("declination"), do: "辞退 😥"
  def current_state(state), do: state

  def state_color("application"), do: "blue"
  def state_color("selectioning"), do: "orange"
  def state_color("acceptance"), do: "green"
  def state_color("rejected"), do: "red"
  def state_color("declination"), do: "purple"

  def step_color("application"), do: "stone"
  def step_color("document_screening"), do: "orange"
  def step_color("task_screening"), do: "amber"
  def step_color("surgery"), do: "lime"
  def step_color("first_interview"), do: "emerald"
  def step_color("manager_interview"), do: "teal"
  def step_color("president_interview"), do: "cyan"
end
