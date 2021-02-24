require 'test_helper'

class TimesheetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @timesheet = timesheets(:one)
  end
  
  test "should redirect update when not logged in" do
    patch timesheet_path(@timesheet), params: { timesheet: {   hours: @timesheet.hours, date_of_service: @timesheet.date_of_service } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Timesheet.count' do
      delete timesheet_path(@timesheet)
    end
    assert_redirected_to login_url
  end
end
