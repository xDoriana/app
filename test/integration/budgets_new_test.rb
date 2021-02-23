require 'test_helper'

class BudgetsNewTest < ActionDispatch::IntegrationTest
    include ApplicationHelper

  def setup
    @user = users(:jane)
  end

  test "redirect new as logged-out user" do
    get new_budget_path
    assert_redirected_to login_path
    follow_redirect!
    get users_path
    assert_template 'users/index'
  end

  test "new as logged-in user" do
    log_in_as(@user)
    get new_budget_path
    assert_template 'budgets/new'
    assert_select 'title', full_title("Add Budget")
  end

  test "invalid form information" do
    log_in_as(@user)
    get new_budget_path
    assert_no_difference 'Budget.count' do
      post budgets_path, params: { budget: { employer_id: '', hours: 0, start_date: '2021-01-02', end_date: '2021-01-01' } }
    end
    assert_not flash.empty?
    assert_template 'budgets/new'
  end

  test "valid form information" do
    log_in_as(@user)
    get new_budget_path
    assert_difference 'Budget.count', 1 do
      post budgets_path, params: { budget: { employer_id: '1', hours: '10', start_date: '2021-01-01', end_date: '2021-01-02' } }
# de ce nu se schimba aici Budget.count si imi zice la debugger ca ii nil???? ca n-am authenticity token????
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'budgets/index'
  end

end