RSpec.describe Shift, type: :model do
  let(:shift) { FactoryBot.create(:shift) }

  it "is valid with valid attributes" do
    expect(shift).to be_valid
  end

  it "is not valid without a shift_start" do
    shift.user = nil
    expect(shift).to_not be_valid
  end

  it "is not valid without a shift_start" do
    shift.schedule = nil
    expect(shift).to_not be_valid
  end

  it "is not valid without a shift_start" do
    shift.shift_start = nil
    expect(shift).to_not be_valid
  end

  it "is not valid without a shift_end" do
    shift.shift_end = nil
    expect(shift).to_not be_valid
  end

  it "returns the formatted shift_start using format_shift" do
    expect(shift.format_shift(shift.shift_start)).to eq(shift.shift_start.strftime("%b %d, %Y @ %H:%M"))
  end

  it "returns the formatted shift_end using format_shift" do
    expect(shift.format_shift(shift.shift_end)).to eq(shift.shift_end.strftime("%b %d, %Y @ %H:%M"))
  end
end
