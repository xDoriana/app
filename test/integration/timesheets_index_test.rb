require 'test_helper'

class TimesheetsIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @timesheet = timesheets(:one)
  end

  test "redirect index as logged-out user" do
    get timesheets_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get timesheets_path
    assert_template 'timesheets/index'
    assert_select 'title', full_title("Timesheets")
    assert_select 'h1', text: "Timesheets"
    # 'Create new' Timesheet link
    assert_select 'a[href=?]', new_timesheet_path, text: "Create new"
    # Timesheet 'View' and 'Edit' links
    assert_select 'a[href=?]', timesheet_path(@timesheet), text: 'View'
    assert_select 'a[href=?]', edit_timesheet_path(@timesheet), text: 'Edit'
    # Delete timesheet
    assert_select 'a[href=?]', timesheet_path(@timesheet), text: 'Delete', method: :delete
    assert_difference 'Timesheet.count', -1 do
      delete timesheet_path(@timesheet)
    end
  end
end