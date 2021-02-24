require 'test_helper'

class BudgetTest < ActiveSupport::TestCase

  def setup
    @budget = budgets(:one)
  end

  test "should be valid" do
    assert @budget.valid?
  end

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

  # test timesheets_total_hours

  test "hours_usage_rate" do
    assert_equal(40, @budget.hours_usage_rate)
  end

  test "budget hours should cover timesheet hours" do
    @budget.hours = 1
    assert_not @budget.valid?
    assert_includes(@budget.errors[:hours], "do not cover existing timesheets' hours. Timesheets hours to cover: #{@budget.timesheets_total_hours}")
  end

  test "start_date should come before end_date" do
    @budget.start_date = Date.new(2021, 01, 12)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:start_date], "must come before or be on the same day as end date")
  end

  # test has_assoc_timesheets?

  # test assoc_timesheets_count

  # test assoc_employees_count

  test "#oldest_timesheet" do
  date = Date.new(2021, 01, 5)
    assert_equal(date, @budget.oldest_timesheet)
  end

  test "#most_recent_timesheet" do
  date = Date.new(2021, 01, 8)
    assert_equal(date, @budget.most_recent_timesheet)
  end

  test "budget date range covers timesheets' dates" do
    @budget.start_date = Date.new(2021, 01, 6)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:start_date], "does not cover timesheets' dates range. Range to cover: #{@budget.oldest_timesheet} - #{@budget.most_recent_timesheet}")
    @budget.end_date = Date.new(2021, 01, 7)
    assert_not @budget.valid?
    assert_includes(@budget.errors[:end_date], "does not cover timesheets' dates range. Range to cover: #{@budget.oldest_timesheet} - #{@budget.most_recent_timesheet}")
  end
end
