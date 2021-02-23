require 'test_helper'

class TimesheetsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
    @timesheet = timesheets(:one)
  end

  test "redirect edit as logged-out user" do
    get edit_timesheet_path(@timesheet)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
    patch timesheet_path(@timesheet), params: { timesheet: { employee_id: 0,
# oare aici ii ok daca pun employer_id, desi ala teoretic ii blocat la editare? oare trebe ghilimele la employee_id si budget_id??
                                                            budget_id: 0,
                                                            hours:  0,
                                                            date_of_service: '2021-01-12' } }
    assert_template 'timesheets/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
    hours = 2
    date_of_service = "2021-01-10"
    patch timesheet_path(@timesheet), params: { timesheet: { hours:  hours,
                                                            date_of_service: date_of_service } }
    assert_not flash.empty?
    assert_redirected_to timesheets_path
    @timesheet.reload
    assert_equal hours,  @timesheet.hours
    assert_equal date_of_service.to_date, @timesheet.date_of_service
  end
  
end