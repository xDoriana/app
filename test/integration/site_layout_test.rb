require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
  end

  test "layout links as logged-in user" do
    log_in_as(@user)
    get root_path
    assert_template 'users/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", employers_path
    assert_select "a[href=?]", employees_path
    assert_select "a[href=?]", budgets_path
    assert_select "a[href=?]", timesheets_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end

end