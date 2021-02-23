require 'test_helper'

class BudgetsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
    @budget = budgets(:one)
  end

  test "redirect edit as logged-out user" do
    get edit_budget_path(@budget)
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "edit as logged-in user" do
    log_in_as(@user)
    get edit_budget_path(@budget)
    assert_template 'budgets/edit'
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_budget_path(@budget)
    assert_template 'budgets/edit'
    patch budget_path(@budget), params: { budget: { employer_id: 0,
# oare aici ii ok daca pun employer_id, desi ala teoretic ii blocat la editare? la employer_id trebe sa pun ghilimele???
                                                    hours:  0,
                                                    start_date: '2021-01-02',
                                                    end_date: '2021-01-01' } }
    assert_template 'budgets/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_budget_path(@budget)
    assert_template 'budgets/edit'
    hours  = 11
    start_date = "2021-01-01"
    end_date = "2021-01-11"
    patch budget_path(@budget), params: { budget: { hours:  hours,
                                                    start_date: start_date,
                                                    end_date: end_date } }
    assert_not flash.empty?
    assert_redirected_to budgets_path
    @budget.reload
    assert_equal hours,  @budget.hours
    assert_equal start_date.to_date, @budget.start_date
    assert_equal end_date.to_date, @budget.end_date
  end
  
end