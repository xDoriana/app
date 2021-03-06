require 'test_helper'

class EmployeesNewTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employer = employers(:one)
  end

  test "redirect new as logged-out user" do
    get new_employee_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_employee_path
    assert_template 'employees/new'
    assert_select 'title', full_title("Add Employee")
    assert_select 'h1', text: "Add a new Employee"
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_employee_path
    assert_no_difference 'Employee.count' do
      post employees_path, params: { employee: 
      { employer_id: "", first_name: "", last_name: "" } }
    end
    assert_not flash.empty?
    assert_template 'employees/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_employee_path
    assert_difference 'Employee.count', 1 do
      post employees_path, params: { employee: 
      { employer_id: @employer.id, first_name: "Foo", last_name: "Bar" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'employees/index'
  end
end