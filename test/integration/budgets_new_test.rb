require 'test_helper'

class BudgetsNewTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:jane)
    @employer = employers(:one)
  end

  test "redirect new as logged-out user" do
    get new_budget_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_budget_path
    assert_template 'budgets/new'
    assert_select 'title', full_title("Add Budget")
    assert_select 'h1', text: "Add a new Budget"
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_budget_path
    assert_no_difference 'Budget.count' do
      post budgets_path, params: { budget: 
        { employer_id: '', hours: '2', start_date: '2021-01-02', end_date: '2021-01-03' } }
    end
    assert_not flash.empty?
    assert_template 'budgets/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_budget_path
    assert_difference 'Budget.count', 1 do
      post budgets_path, params: { budget: 
        { employer_id: @employer.id, hours: '10', start_date: '2021-01-01', end_date: '2021-01-02' } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'budgets/index'
  end
end