require 'test_helper'

class BudgetTest < ActiveSupport::TestCase

  def setup
    @budget = budgets(:one)
  end

  test "should be valid" do
    assert @budget.valid?
  end

  # Hours
  test "hours should be present" do
    @budget.hours = ""
    assert_not @budget.valid?
  end

  test "hours should be greater than 0" do
    @budget.hours = 0
    assert_not @budget.valid?
  end

  test "hours should be integer" do
    @budget.hours = 0.5
    assert_not @budget.valid?
  end

  ## timesheets_total_hours

  ## hours_usage_rate

  test "budget hours should cover timesheet hours" do
    @budget.hours = 1
    assert_not @budget.valid?
    assert_includes(@budget.errors[:hours], "do not cover existing timesheets")
  end

  test "start_date should come before end_date" do
    @budget.start_date = Date.new(2021, 01, 12)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:start_date], "must come before or be on the same day as end date")
  end

  ## has_assoc_timesheets?

  ## assoc_timesheets_count

  ## assoc_employees_count

  ## oldest_timesheet

  ## most_recent_timesheet

  test "budget date range covers timesheets' dates" do
    @budget.start_date = Date.new(2021, 01, 6)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:start_date], "does not cover timesheet dates")
    @budget.end_date = Date.new(2021, 01, 7)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:end_date], "does not cover timesheet dates")
  end
end
