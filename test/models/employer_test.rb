require 'test_helper'

class EmployerTest < ActiveSupport::TestCase

  def setup
    @employer = employers(:one)
  end

  test "should be valid" do
    assert @employer.valid?
  end

  test "name should be present" do
    @employer.first_name = "" || @employer.last_name = ""
    assert_not @employer.valid?
  end

  test "name should not be too long" do
    @employer.first_name = "a" * 51 || @employer.last_name = "a" * 51
    assert_not @employer.valid?
  end

  # test has_assoc_budgets?

  # test assoc_budgets_count

  # test has_assoc_employees?

  # test assoc_employees_count

  # test total_budgets_hours

  # test timesheets_hours_from_budgets_hours

  test "#budgets_hours_usage_rate" do
    assert_equal(18.18, @employer.budgets_hours_usage_rate)
  end

  test "#budgets_start_date" do
  date = Date.new(2021, 01, 1)
    assert_equal(date, @employer.budgets_start_date)
  end

  test "#budgets_end_date" do
  date = Date.new(2021, 01, 11)
    assert_equal(date, @employer.budgets_end_date)
  end

  test "#budgets_total_days" do
    assert_equal(20, @employer.budgets_total_days)
  end

  # test assoc_timesheets_count
end
