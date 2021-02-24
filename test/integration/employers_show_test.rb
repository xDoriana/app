require 'test_helper'

class EmployersShowTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employer = employers(:one)
  end

  test "redirect show as logged-out user" do
    get employer_path(@employer)
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "show as logged-in user" do
    log_in_as(@user)
    get employer_path(@employer)
    assert_template 'employers/show'
    assert_select 'title', full_title("Employer " + @employer.id.to_s)
    assert_select 'h1', text: "Employer " + @employer.id.to_s
    # Edit employer button
    assert_select 'a[href=?]', edit_employer_path(@employer.id), text: 'Edit'
    # Delete employer button
    assert_select 'a[href=?]', employer_path(@employer.id), text: 'Delete', method: :delete
    assert_difference 'Employer.count', -1 do
      delete employer_path(@employer)
    end
  end 
end