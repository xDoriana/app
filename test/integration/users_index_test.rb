require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
  end

  test "index as logged-out user including login link" do
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', login_path, text: 'Log in', count: 2
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  end

# unde pun testarea pt meniul ce imi apare daca esti sau nu logged-in? la users index test sau la site layout test? momentan e la site layout test
  
end
