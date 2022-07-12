RSpec.describe Schedule, type: :model do
  let(:schedule) { FactoryBot.create(:schedule) }

  it "is valid with valid attributes" do
    expect(schedule).to be_valid
  end

  it "is not valid without a first_day" do
    schedule.first_day = nil
    expect(schedule).to_not be_valid
  end

  it "is not valid without a last_day" do
    schedule.last_day = nil
    expect(schedule).to_not be_valid
  end

  it "returns the schedule name (first_day - last_day) for a schedule" do
    expect(schedule.schedule_name).to eq("#{schedule.first_day.strftime("%b %d, %Y")} - #{schedule.last_day.strftime("%b %d, %Y")}")
  end
end
