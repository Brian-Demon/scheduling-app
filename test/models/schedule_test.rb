require "test_helper"

class ScheduleTest < ActiveSupport::TestCase
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
    @schedule = Schedule.create(
      first_day: Date.new(1985, 11, 18),
      last_day: Date.new(1989, 7, 14),
    )
  end

  def teardown
    User.destroy_all
    Schedule.destroy_all
  end

  test "schedule_name returns correctly formatted schedule name" do
    assert_equal("Nov 18, 1985 - Jul 14, 1989", @schedule.schedule_name)
  end
end
