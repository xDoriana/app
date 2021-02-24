require 'test_helper'

class EmployersIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employer = employers(:one)
  end

  test "redirect index as logged-out user" do
    get employers_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get employers_path
    assert_template 'employers/index'
    assert_select 'title', full_title("Employers")
    assert_select 'h1', text: "Employers"
    # 'Create new' Employer link
    assert_select 'a[href=?]', new_employer_path, text: "Create new"
    # Employer 'View' and 'Edit' links
    assert_select 'a[href=?]', employer_path(@employer), text: 'View'
    assert_select 'a[href=?]', edit_employer_path(@employer), text: 'Edit'
    # Delete employer
    assert_select 'a[href=?]', employer_path(@employer), text: 'Delete', method: :delete
    assert_difference 'Employer.count', -1 do
      delete employer_path(@employer)
    end
  end
end