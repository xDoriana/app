require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @employee = employees(:one)
  end

  test "should be valid" do
    assert @employee.valid?
  end
  
end
