require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:one)
  end

  test "should redirect index when not logged in" do
    get employees_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get employee_path(@employee)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_employee_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_employee_path(@employee)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch employee_path(@employee), params: { employee: { first_name: @employee.first_name,
                                              last_name: @employee.last_name } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Employee.count' do
      delete employee_path(@employee)
    end
    assert_redirected_to login_url
  end

end
