require 'test_helper'

class TimesheetsShowTest < ActionDispatch::IntegrationTest
    include ApplicationHelper
# aici am metoda full title

  def setup
    @user = users(:jane)
    @timesheet = timesheets(:one)
  end

  test "redirect show as logged-out user" do
    get timesheet_path(@timesheet)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "show as logged-in user" do
    log_in_as(@user)
    get timesheet_path(@timesheet)
    assert_template 'timesheets/show'
    assert_select 'title', full_title("Timesheet")
    assert_select 'h1', text: "Timesheet"
    assert_select 'h3', text: "ID"
    assert_select 'h3', text: "Associated employee"
    assert_select 'h3', text: "Associated budget"
    assert_select 'h3', text: "Associated employer"
    assert_select 'h3', text: "Hours"
    assert_select 'h3', text: "Date of service"
    # Edit timesheet button
    assert_select 'a[href=?]', edit_timesheet_path(@timesheet), text: 'Edit'
    # Delete timesheet button
    assert_select 'a[href=?]', timesheet_path(@timesheet), text: 'Delete', method: :delete
    assert_difference 'Timesheet.count', -1 do
      delete timesheet_path(@timesheet)
    end
  end 

end