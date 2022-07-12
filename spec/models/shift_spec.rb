RSpec.describe Shift, type: :model do
  let(:shift) { FactoryBot.create(:shift) }

  it "is valid with valid attributes" do
    expect(shift).to be_valid
  end

  it "is not valid without a user" do
    shift.user = nil
    expect(shift).to_not be_valid
    expect("User must be present").to eq(shift.errors.full_messages.last)
  end

  it "is not valid without a schedule" do
    shift.schedule = nil
    expect(shift).to_not be_valid
    expect("Schedule must be present").to eq(shift.errors.full_messages.last)
  end

  it "is not valid without a shift_start" do
    shift.shift_start = nil
    expect(shift).to_not be_valid
    expect("Shift start must be present").to eq(shift.errors.full_messages.last)
  end

  it "is not valid without a shift_end" do
    shift.shift_end = nil
    expect(shift).to_not be_valid
    expect("Shift end must be present").to eq(shift.errors.full_messages.last)
  end

  it "returns the formatted shift_start using format_shift" do
    expect(shift.format_shift(shift.shift_start)).to eq("Sep 01, 2022 @ 23:00")
  end

  it "returns the formatted shift_end using format_shift" do
    expect(shift.format_shift(shift.shift_end)).to eq("Sep 02, 2022 @ 07:00")
  end
end
