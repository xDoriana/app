require 'test_helper'

class TimesheetsNewTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employee = employees(:one)
    @budget = budgets(:one)
  end

  test "redirect new as logged-out user" do
    get new_timesheet_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_timesheet_path
    assert_template 'timesheets/new'
    assert_select 'title', full_title("Add Timesheet")
    assert_select 'h1', text: "Add a new Timesheet"
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_timesheet_path
    assert_no_difference 'Timesheet.count' do
      post timesheets_path, params: { timesheet: 
        { employee_id: '0', budget_id: '0', hours: '0', date_of_service: '2021-01-02' } }
    end
    assert_not flash.empty?
    assert_template 'timesheets/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_timesheet_path
    assert_difference 'Timesheet.count', 1 do
      post timesheets_path, params: { timesheet: 
        { employee_id: @employee.id, budget_id: @budget.id, hours: '1', date_of_service: '2021-01-10' } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'timesheets/index'
  end
end