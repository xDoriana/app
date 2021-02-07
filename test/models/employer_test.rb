require 'test_helper'

class EmployerTest < ActiveSupport::TestCase

  def setup
    @employer = Employer.new(first_name: "Example", last_name: "User")
  end

  test "should be valid" do
    assert @employer.valid?
  end

  test "name should be present" do
    @employer.first_name = "" || @employer.last_name = ""
    assert_not @employer.valid?
  end

  test "name should not be too long" do
    @employer.first_name = "a" * 51 || @employer.last_name = "a" * 51
    assert_not @employer.valid?
  end

end
