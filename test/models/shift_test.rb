require "test_helper"

class ShiftTest < ActiveSupport::TestCase
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
    @shift_start = DateTime.new(1985, 11, 18, 12, 00)
    @shift_end = DateTime.new(1985, 11, 18, 20, 00)
    @shift = Shift.create(
      user: @user,
      schedule: @schedule,
      shift_start: @shift_start,
      shift_end: @shift_end,
    )
  end

  def teardown
    User.destroy_all
    Schedule.destroy_all
    Shift.destroy_all
  end

  test "format_shift returns correctly formatted shift" do
    shift_start = @shift.format_shift(@shift.shift_start)
    shift_end = @shift.format_shift(@shift.shift_end)

    assert_equal("Nov 18, 1985 @ 12:00", shift_start)
    assert_equal("Nov 18, 1985 @ 20:00", shift_end)
  end
end
