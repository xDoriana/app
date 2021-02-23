require 'test_helper'

class EmployeesShowTest < ActionDispatch::IntegrationTest
    include ApplicationHelper
# aici am metoda full title

  def setup
    @user = users(:jane)
    @employee = employees(:one)
  end

  test "redirect show as logged-out user" do
    get employee_path(@employee)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "show as logged-in user" do
    log_in_as(@user)
    get employee_path(@employee)
    assert_template 'employees/show'
    assert_select 'title', full_title("Employee")
    assert_select 'h1', text: "Employee"
    assert_select 'h3', text: "ID"
    assert_select 'h3', text: "Name"
    assert_select 'h3', text: "Associated employer:"
    assert_select 'h3', text: "Associated timesheets:"
    # Edit employee button
    assert_select 'a[href=?]', edit_employee_path(@employee), text: 'Edit'
    # Delete employee button
    assert_select 'a[href=?]', employee_path(@employee), text: 'Delete', method: :delete
    assert_difference 'Employee.count', -1 do
      delete employee_path(@employee)
    end
  end 

end