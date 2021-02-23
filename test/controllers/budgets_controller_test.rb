require 'test_helper'

class BudgetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @budget = budgets(:one)
  end

  test "should redirect index when not logged in" do
    get budgets_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get budget_path(@budget)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_budget_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_budget_path(@budget)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch budget_path(@budget), params: { budget: { hours: @budget.hours, start_date: @budget.start_date, end_date: @budget.end_date } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Budget.count' do
      delete budget_path(@budget)
    end
    assert_redirected_to login_url
  end
# mai am ceva ce pot adauga la testele de controller?
end
