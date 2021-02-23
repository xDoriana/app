require 'test_helper'

class BudgetsShowTest < ActionDispatch::IntegrationTest
    include ApplicationHelper
# aici am metoda full title

  def setup
    @user = users(:jane)
    @budget = budgets(:one)
  end

  test "redirect show as logged-out user" do
    get budget_path(@budget)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "show as logged-in user" do
    log_in_as(@user)
    get budget_path(@budget)
    assert_template 'budgets/show'
    assert_select 'title', full_title("Budget")
    assert_select 'h1', text: "Budget"
    assert_select 'h3', text: "ID"
    assert_select 'h3', text: "Employer"
    assert_select 'h3', text: "Associated timesheets"
    assert_select 'h3', text: "Start and end dates"
    # Edit budget button
    assert_select 'a[href=?]', edit_budget_path(@budget), text: 'Edit'
    # Delete budget button
    assert_select 'a[href=?]', budget_path(@budget), text: 'Delete', method: :delete
    assert_difference 'Budget.count', -1 do
      delete budget_path(@budget)
    end
  end 

end