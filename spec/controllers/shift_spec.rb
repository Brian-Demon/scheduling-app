require "rails_helper"

RSpec.describe "Shifts", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:shift, 10)
      @shift = Shift.first
      get "/api/v1/shifts"
      @first_shift_data = json["data"][0]["attributes"]
    end
    
    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns all shifts" do
      expect(json["data"].size).to eq(10)
    end

    it "returns correct shift_start" do
      expect(Date.parse(@first_shift_data["shift_start"])).to eq(@shift.shift_start.strftime("%B %d, %Y").to_date)
    end

    it "returns correct shift_end" do
      expect(Date.parse(@first_shift_data["shift_end"])).to eq(@shift.shift_end.strftime("%B %d, %Y").to_date)
    end
  end

  describe "GET /show" do
    let!(:shift) { FactoryBot.create(:shift) }

    before do
      get "/api/v1/shifts/#{shift.id}"
      @shift_data = json["data"]["attributes"]
    end

    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns correct shift_start" do
      expect(Date.parse(@shift_data["shift_start"])).to eq(shift.shift_start.strftime("%B %d, %Y").to_date)
    end

    it "returns correct shift_end" do
      expect(Date.parse(@shift_data["shift_end"])).to eq(shift.shift_end.strftime("%B %d, %Y").to_date)
    end
  end

  describe "POST /create" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:schedule) { FactoryBot.create(:schedule) }
    let!(:new_shift) { FactoryBot.create(:shift) }

    before do
      post "/api/v1/shifts",
        params:
        { 
          shift: 
          {
            user_id: user.id,
            schedule_id: schedule.id,
            shift_start: new_shift.shift_start.to_time,
            shift_end: new_shift.shift_end.to_time,
          }
        }
    end

    it "returns status code 201 (created)" do
      expect(response).to have_http_status(:created)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("Shift for #{user.employee_name} created: #{new_shift.format_shift(new_shift.shift_start)} - #{new_shift.format_shift(new_shift.shift_end)}")
    end

    it "newly created shift has correct shift_start" do
      expect(Shift.last.shift_start).to eq(new_shift.shift_start)
    end

    it "newly created shift has correct shift_end" do
      expect(Shift.last.shift_end).to eq(new_shift.shift_end)
    end
  end

  describe "PATCH /update" do
    let!(:shift) { FactoryBot.create(:shift) }

    before do
      patch "/api/v1/shifts/#{shift.id}",
        params:
        { 
          shift: 
          {
            user_id: shift.user.id,
            schedule_id: shift.schedule.id,
            shift_start: shift.shift_start.to_time,
            shift_end: shift.shift_end.to_time,
          }
        }
      shift.reload
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("Shift for #{shift.user.employee_name} updated: #{shift.format_shift(shift.shift_start)} - #{shift.format_shift(shift.shift_end)}")
    end

    it "newly created shift has correct shift_start" do
      expect(Shift.last.shift_start).to eq(shift.shift_start)
    end

    it "newly created shift has correct shift_end" do
      expect(Shift.last.shift_end).to eq(shift.shift_end)
    end
  end

  describe "DELETE /destroy" do
    let!(:shift_one) { FactoryBot.create(:shift) }
    let!(:shift_two) { FactoryBot.create(:shift) }
    let!(:deleted_shift_user_name) { shift_one.user.employee_name }
    let!(:deleted_shift_schedule_name) { shift_one.schedule.schedule_name }

    before do
      delete "/api/v1/shifts/#{shift_one.id}"
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("Shift owned by #{deleted_shift_user_name} for schedule #{deleted_shift_schedule_name} successfully deleted")
    end

    it "the expected shift to be deleted is deleted" do
      expect(Shift.count).to eq(1)
      expect(Shift.first).to eq(shift_two)
    end
  end
end