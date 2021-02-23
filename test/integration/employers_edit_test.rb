require 'test_helper'

class EmployersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
    @employer = employers(:one)
  end

  test "redirect edit as logged-out user" do
    get edit_employer_path(@employer)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_employer_path(@employer)
    assert_template 'employers/edit'
  end 

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_employer_path(@employer)
    assert_template 'employers/edit'
    patch employer_path(@employer), params: { employer: { first_name:  "",
                                                  last_name: "" } }
    assert_template 'employers/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_employer_path(@employer)
    assert_template 'employers/edit'
    first_name  = "Foo"
    last_name = "Bar"
    patch employer_path(@employer), params: { employer: { first_name:  first_name,
                                                  last_name: last_name } }
    assert_not flash.empty?
    assert_redirected_to employers_path
    @employer.reload
    assert_equal first_name,  @employer.first_name
    assert_equal last_name, @employer.last_name
  end
  
end