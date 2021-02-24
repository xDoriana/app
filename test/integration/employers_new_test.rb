require 'test_helper'

class EmployersNewTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
  end

  test "redirect new as logged-out user" do
    get new_employer_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_employer_path
    assert_template 'employers/new'
    assert_select 'title', full_title("Add Employer")
    assert_select 'h1', text: "Add a new Employer"
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_employer_path
    assert_no_difference 'Employer.count' do
      post employers_path, params: { employer: { first_name: "", last_name: "" } }
    end
    assert_not flash.empty?
    assert_template 'employers/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_employer_path
    assert_difference 'Employer.count', 1 do
      post employers_path, params: { employer: { first_name: "Foo", last_name: "Bar" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'employers/index'
  end
end