require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase

  def setup
    @employee = employees(:one)
    @employer = employers(:two)
    @budget = budgets(:one)
    @timesheet = Timesheet.new(employee: @employee, budget: @budget, hours: 1, date_of_service: '2021-01-02')
    @timesheet2 = timesheets(:three)
    # timesheet2 il folosesc la validarea pt hours should be within budget hours left
  end

  test "should be valid" do
    assert @timesheet.valid?
  end

  # Hours
  test "hours should be present" do
    @timesheet.hours = ""
    assert_not @timesheet.valid?
  end

  test "hours should be greater than 0" do
    @timesheet.hours = 0
    assert_not @timesheet.valid?
  end

  test "hours should be integer" do
    @timesheet.hours = 0.5
    assert_not @timesheet.valid?
  end

  test "hours should be within budget hours" do
    @timesheet.hours = 11
    assert_not @timesheet.valid?
    assert_includes(@timesheet.errors[:hours], "do not fall within budget hours. Budget hours: #{@budget.hours}")
  end

  test "hours left" do

  end

  test "hours should be within budget hours left" do
    @timesheet.hours = 8
    assert_not @timesheet.valid?
    assert_includes(@timesheet.errors[:hours], "do not fall within budget hours left. Hours left: #{@timesheet.hours_left}")
  end

  test "hours should fit in a day" do
    @timesheet.hours = 25
    assert_not @timesheet.valid?
    assert_includes(@timesheet.errors[:hours], "do not fit in a current day on Earth. You must have come from the future or a different planet, you advanced workaholic being, you! Does this mean the end of our childhood, master Overlord? Also, do you get enough sleep?")
  end

  # Employee
  test "employee_id should be present" do
    @timesheet.employee_id = ""
    assert_not @timesheet.valid?
  end

  test "employee and budget should belong to same employer" do
    @timesheet.employee.employer = @employer
    assert_not @timesheet.valid?
    assert_includes(@timesheet.errors[:employee], "and budget do not belong to the same employer")
  end

  # Budget
  test "budget_id should be present" do
    @timesheet.budget_id = ""
    assert_not @timesheet.valid?
  end

  # Date
  test "date_of_service should be present" do
    @timesheet.date_of_service = ""
    assert_not @timesheet.valid?
  end

  test "date_of_service should be in budget date range" do
    @timesheet.date_of_service = Date.new(2021, 01, 12)
    assert_not @timesheet.valid?
    assert_includes(@timesheet.errors[:date_of_service], "does not fall in budget date range. Budget date range: #{@budget.start_date} - #{@budget.end_date}")
  end
end