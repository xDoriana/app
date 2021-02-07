require 'test_helper'

class BudgetTest < ActiveSupport::TestCase

  def setup
    @budget = budgets(:one)
  end

  test "should be valid" do
    assert @budget.valid?
  end

end
