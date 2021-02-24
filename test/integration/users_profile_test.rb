require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title("Profile")
    assert_select 'h1', text: "User"
    assert_select 'a[href=?]', edit_user_path(@user), text: 'Edit'
    assert_select 'a[href=?]', user_path(@user), text: 'Delete', method: :delete
    assert_difference 'User.count', -1 do
        delete user_path(@user)
    end
  end
end