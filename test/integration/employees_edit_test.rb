require 'test_helper'

class EmployeesEditTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employee = employees(:one)
  end

  test "redirect edit as logged-out user" do
    get edit_employee_path(@employee)
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    assert_select 'title', full_title("Edit Employee " + @employee.id.to_s)
    assert_select 'h1', text: "Edit Employee " + @employee.id.to_s
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    patch employee_path(@employee), params: { employee:
      { first_name: "", last_name: "" } }
    assert_template 'employees/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    first_name  = "Foo"
    last_name = "Bar"
    patch employee_path(@employee), params: { employee: 
      { first_name:  first_name, last_name: last_name } }
    assert_not flash.empty?
    assert_redirected_to employees_path
    @employee.reload
    assert_equal first_name, @employee.first_name
    assert_equal last_name, @employee.last_name
  end
end