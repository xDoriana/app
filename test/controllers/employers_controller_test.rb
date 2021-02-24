require 'test_helper'

class EmployersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @employer = employers(:one)
  end

  # test "should redirect index when not logged in" do
  #   get employers_path
  #   assert_not flash.empty?
  #   assert_redirected_to login_url
  # end

  # test "should redirect show when not logged in" do
  #   get employer_path(@employer)
  #   assert_not flash.empty?
  #   assert_redirected_to login_url
  # end

  # test "should redirect new when not logged in" do
  #   get new_employer_path
  #   assert_not flash.empty?
  #   assert_redirected_to login_url
  # end

  # test "should redirect edit when not logged in" do
  #   get edit_employer_path(@employer)
  #   assert_not flash.empty?
  #   assert_redirected_to login_url
  # end

  test "should redirect update when not logged in" do
    patch employer_path(@employer), params: { employer: 
      { first_name: @employer.first_name, last_name: @employer.last_name} }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Employer.count' do
      delete employer_path(@employer)
    end
    assert_redirected_to login_url
  end
end
