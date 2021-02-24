require 'test_helper'

class EmployeesIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employee = employees(:one)
  end

  test "redirect index as logged-out user" do
    get employees_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get employees_path
    assert_template 'employees/index'
    assert_select 'title', full_title("Employees")
    assert_select 'h1', text: "Employees"
    # 'Create new' Employee link
    assert_select 'a[href=?]', new_employee_path, text: "Create new"
    # Employee 'View' and 'Edit' links
    assert_select 'a[href=?]', employee_path(@employee), text: 'View'
    assert_select 'a[href=?]', edit_employee_path(@employee), text: 'Edit'
    # Delete employee
    assert_select 'a[href=?]', employee_path(@employee), text: 'Delete', method: :delete
    assert_difference 'Employee.count', -1 do
      delete employee_path(@employee)
    end
  end
end