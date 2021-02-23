require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @employee = employees(:one)
  end

  test "should be valid" do
    assert @employee.valid?
  end

  test "name should be present" do
    @employee.first_name = "" || @employee.last_name = ""
    assert_not @employee.valid?
  end

  test "name should not be too long" do
    @employee.first_name = "a" * 51 || @employee.last_name = "a" * 51
    assert_not @employee.valid?
  end

  ## assoc_timesheets_count

  ## assoc_budgets_count
  
end
