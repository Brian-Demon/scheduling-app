require "rails_helper"

RSpec.describe "Schedules", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:schedule, 10)
      @schedule = Schedule.first
      get "/api/v1/schedules"
      @first_schedule_data = json["data"][0]["attributes"]
    end
    
    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns all schedules" do
      expect(json["data"].size).to eq(10)
    end

    it "returns correct first_day" do
      first_day_year = @first_schedule_data["last_day"].split("T").first.split("-").first.to_i
      first_day_month = @first_schedule_data["last_day"].split("T").first.split("-").second.to_i
      first_day_day = @first_schedule_data["last_day"].split("T").first.split("-").third.to_i
      expect(Date.new(first_day_year, first_day_month, first_day_day)).to eq(@schedule.last_day.to_date)
    end

    it "returns correct last_day" do
      last_day_year = @first_schedule_data["last_day"].split("T").first.split("-").first.to_i
      last_day_month = @first_schedule_data["last_day"].split("T").first.split("-").second.to_i
      last_day_day = @first_schedule_data["last_day"].split("T").first.split("-").third.to_i
      expect(Date.new(last_day_year, last_day_month, last_day_day)).to eq(@schedule.last_day.to_date)
    end
  end

  describe "GET /show" do
    let!(:schedule) { FactoryBot.create(:schedule) }

    before do
      get "/api/v1/schedules/#{schedule.id}"
      @schedule_data = json["data"]["attributes"]
    end

    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns correct first_day" do
      first_day_year = @schedule_data["first_day"].split("T").first.split("-").first.to_i
      first_day_month = @schedule_data["first_day"].split("T").first.split("-").second.to_i
      first_day_day = @schedule_data["first_day"].split("T").first.split("-").third.to_i
      expect(Date.new(first_day_year, first_day_month, first_day_day)).to eq(schedule.first_day.to_date)
    end

    it "returns correct last_day" do
      last_day_year = @schedule_data["last_day"].split("T").first.split("-").first.to_i
      last_day_month = @schedule_data["last_day"].split("T").first.split("-").second.to_i
      last_day_day = @schedule_data["last_day"].split("T").first.split("-").third.to_i
      expect(Date.new(last_day_year, last_day_month, last_day_day)).to eq(schedule.last_day.to_date)
    end
  end

  describe "POST /create" do
    let!(:new_schedule) { FactoryBot.create(:schedule) }

    before do
      post "/api/v1/schedules",
        params:
        { 
          schedule: 
          {
            first_day: new_schedule.first_day,
            last_day: new_schedule.last_day,
          }
        }
    end

    it "returns status code 201 (created)" do
      expect(response).to have_http_status(:created)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{new_schedule.schedule_name} successfully created")
    end

    it "newly created schedule has correct first_day" do
      expect(Schedule.last.first_day).to eq(new_schedule.first_day)
    end

    it "newly created schedule has correct last_day" do
      expect(Schedule.last.last_day).to eq(new_schedule.last_day)
    end
  end

  describe "PATCH /update" do
    let!(:schedule) { FactoryBot.create(:schedule) }

    before do
      patch "/api/v1/schedules/#{schedule.id}",
        params:
        { 
          schedule: 
          {
            email: "updated_email",
            first_name: "updated_first_name",
            last_name: "updated_last_name",
            title: "updated_title",
            role: "updated_role",
            provider: "updated_provider",
            uid: "updated_uid",
          }
        }
      schedule.reload
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{schedule.schedule_name} successfully updated")
    end

    it "newly created schedule has correct first_day" do
      expect(Schedule.last.first_day).to eq(schedule.first_day)
    end

    it "newly created schedule has correct last_day" do
      expect(Schedule.last.last_day).to eq(schedule.last_day)
    end
  end

  describe "DELETE /destroy" do
    let!(:schedule_one) { FactoryBot.create(:schedule) }
    let!(:schedule_two) { FactoryBot.create(:schedule) }
    let!(:deleted_schedule_name) { schedule_one.schedule_name }

    before do
      delete "/api/v1/schedules/#{schedule_one.id}"
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{deleted_schedule_name} successfully deleted")
    end

    it "the expected schedule to be deleted is deleted" do
      expect(Schedule.count).to eq(1)
      expect(Schedule.first).to eq(schedule_two)
    end
  end
end