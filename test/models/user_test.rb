require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.create(
      email: "1@test.com",
      password: "123",
      password_confirmation: "123",
      first_name: "1",
      last_name: "Test",
      title: "bartender",
      role: "employee",
    )
  end

  def teardown
    User.destroy_all
  end

  test "employee_name returns correctly formatted name" do
    assert_equal("1 Test", @user.employee_name)
  end
end
