require 'test_helper'

class TimesheetsEditTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @timesheet = timesheets(:one)
  end

  test "redirect edit as logged-out user" do
    get edit_timesheet_path(@timesheet)
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
    assert_select 'title', full_title("Edit Timesheet " + @timesheet.id.to_s)
    assert_select 'h1', text: "Edit Timesheet " + @timesheet.id.to_s
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
    patch timesheet_path(@timesheet), params: { timesheet: 
      { hours:  '0', date_of_service: '2021-01-30' } }
    assert_not flash.empty?
    assert_template 'timesheets/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_timesheet_path(@timesheet)
    assert_template 'timesheets/edit'
    hours = 2
    date_of_service = "2021-01-10"
    patch timesheet_path(@timesheet), params: { timesheet: 
      { hours:  hours, date_of_service: date_of_service } }
    assert_not flash.empty?
    assert_redirected_to timesheets_path
    @timesheet.reload
    assert_equal hours, @timesheet.hours
    assert_equal date_of_service.to_date, @timesheet.date_of_service
  end
end