require 'test_helper'

class BudgetsIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:jane)
    @budget = budgets(:one)
  end

  test "redirect index as logged-out user" do
    get budgets_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "index as logged-in user" do
    log_in_as(@user)
    get budgets_path
    assert_template 'budgets/index'
    assert_select 'title', full_title("Budgets")
    assert_select 'h1', text: "Budgets"
    # 'Create new' Budget link
    assert_select 'a[href=?]', new_budget_path, text: "Create new"
    # Budget 'View' and 'Edit' links
    assert_select 'a[href=?]', budget_path(@budget), text: 'View'
    assert_select 'a[href=?]', edit_budget_path(@budget), text: 'Edit'
    # Delete budget
    assert_select 'a[href=?]', budget_path(@budget), text: 'Delete', method: :delete
    assert_difference 'Budget.count', -1 do
      delete budget_path(@budget)
    end
  end
end