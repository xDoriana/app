require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:one)
  end

  test "should redirect update when not logged in" do
    patch employee_path(@employee), params: { employee: 
      { first_name: @employee.first_name, last_name: @employee.last_name } }
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
