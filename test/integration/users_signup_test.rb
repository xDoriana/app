require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  test "render new" do
    get new_user_path
    assert_template 'users/new'
    assert_select 'title', full_title("Sign up")
    assert_select 'h1', text: "Sign up"
  end

  test "invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: 
        { first_name:  "", last_name: "", email: "user@invalid", password: "pass", password_confirmation: "word" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: 
        { first_name:  "Example", last_name: "User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
