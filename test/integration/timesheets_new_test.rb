require 'test_helper'

class TimesheetsNewTest < ActionDispatch::IntegrationTest
    include ApplicationHelper

  def setup
    @user = users(:jane)
    @employer = employers(:one)
    @employee = employees(:one)
    @budget = budgets(:one)
# imi trebe toate astea??
  end

  test "redirect new as logged-out user" do
    get new_timesheet_path
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_timesheet_path
    assert_template 'timesheets/new'
    assert_select 'title', full_title("Add Timesheet")
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_timesheet_path
    assert_no_difference 'Timesheet.count' do
      post timesheets_path, params: { timesheet: { employee_id: '0', budget_id: '0', hours: '0', date_of_service: '2021-01-02' } }
    end
    assert_not flash.empty?
    assert_template 'timesheets/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_timesheet_path
    assert_difference 'Timesheet.count', 1 do
      post timesheets_path, params: { timesheet: { employee_id: '1', budget_id: '1', hours: '1', date_of_service: '2021-01-10' } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'timesheets/index'
  end
end

# de ce nu se schimba aici Timesheet.count si imi zice la debugger ca ii nil???? ca n-am authenticity token???? "NoMethodError: undefined method `employer_id' for nil:NilClass"