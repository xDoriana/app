require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase

  def setup
    @employee = employees(:one)
    @budget = budgets(:one)
    @timesheet = timesheets(:one)
  end

  test "should be valid" do
    assert @timesheet.valid?
  end

end
