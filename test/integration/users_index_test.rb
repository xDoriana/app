require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
  end

  test "index as logged-out user" do
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', login_path, text: 'Log in', count: 2
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'title', full_title("Home")
    assert_select 'h1', text: "Welcome to the Timesheet App"
  end
end