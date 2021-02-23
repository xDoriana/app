require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
  end

  test "redirect edit as logged-out user" do
    get edit_user_path(@user)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
  end 

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_user_path(@user)
    first_name  = "Foo"
    last_name  = "Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              email: email,
                                              password: "password",
                                              password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name,  @user.last_name
    assert_equal email, @user.email
  end
  
end