require 'test_helper'

class EmployerTest < ActiveSupport::TestCase

  def setup
    @employer = Employer.new(first_name: "Example", last_name: "User")
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

  ## assoc_budgets_count

  ## assoc_employees_count

  ## total_budgets_hours

  ## timesheets_hours_from_budgets_hours

  ## budgets_hours_usage_rate

  ## budgets_start_date

  ## budgets_end_date

  ## budgets_total_days

  ## assoc_timesheets_count

end
