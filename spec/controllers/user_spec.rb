require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:user, 10)
      @user = User.first
      get "/api/v1/users"
      @first_user_data = json["data"][0]["attributes"]
    end
    
    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns all users" do
      expect(json["data"].size).to eq(10)
    end

    it "returns correct email" do
      expect(@first_user_data["email"]).to eq(@user.email)
    end

    it "returns correct first_name" do
      expect(@first_user_data["first_name"]).to eq(@user.first_name)
    end

    it "returns correct last_name" do
      expect(@first_user_data["last_name"]).to eq(@user.last_name)
    end

    it "returns correct title" do
      expect(@first_user_data["title"]).to eq(@user.title)
    end

    it "returns correct role" do
      expect(@first_user_data["role"]).to eq(@user.role)
    end

    it "returns correct provider" do
      expect(@first_user_data["provider"]).to eq(@user.provider)
    end

    it "returns correct uid" do
      expect(@first_user_data["uid"]).to eq(@user.uid)
    end
  end

  describe "GET /show" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      get "/api/v1/users/#{user.id}"
      @user_data = json["data"]["attributes"]
    end

    it "returns status code 200 (success)" do
      expect(response).to have_http_status(:success)
    end

    it "returns correct email" do
      expect(@user_data["email"]).to eq(user.email)
    end

    it "returns correct first_name" do
      expect(@user_data["first_name"]).to eq(user.first_name)
    end

    it "returns correct last_name" do
      expect(@user_data["last_name"]).to eq(user.last_name)
    end

    it "returns correct title" do
      expect(@user_data["title"]).to eq(user.title)
    end

    it "returns correct role" do
      expect(@user_data["role"]).to eq(user.role)
    end

    it "returns correct provider" do
      expect(@user_data["provider"]).to eq(user.provider)
    end

    it "returns correct uid" do
      expect(@user_data["uid"]).to eq(user.uid)
    end
  end

  describe "POST /create" do
    let!(:new_user) { FactoryBot.create(:user) }

    before do
      post "/api/v1/users",
        params:
        { 
          user: 
          {
            email: new_user.email,
            first_name: new_user.first_name,
            last_name: new_user.last_name,
            title: new_user.title,
            role: new_user.role,
            provider: new_user.provider,
            uid: new_user.uid,
          }
        }
    end

    it "returns status code 201 (created)" do
      expect(response).to have_http_status(:created)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{new_user.employee_name} successfully created")
    end

    it "newly created user has correct email" do
      expect(User.last.email).to eq(new_user.email)
    end

    it "newly created user has correct first_name" do
      expect(User.last.first_name).to eq(new_user.first_name)
    end

    it "newly created user has correct last_name" do
      expect(User.last.last_name).to eq(new_user.last_name)
    end

    it "newly created user has correct title" do
      expect(User.last.title).to eq(new_user.title)
    end

    it "newly created user has correct role" do
      expect(User.last.role).to eq(new_user.role)
    end

    it "newly created user has correct provider" do
      expect(User.last.provider).to eq(new_user.provider)
    end

    it "newly created user has correct uid" do
      expect(User.last.uid).to eq(new_user.uid)
    end
  end

  describe "PATCH /update" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      patch "/api/v1/users/#{user.id}",
        params:
        { 
          user: 
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
      user.reload
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{user.employee_name} successfully updated")
    end

    it "newly created user has correct email" do
      expect(User.last.email).to eq(user.email)
    end

    it "newly created user has correct first_name" do
      expect(User.last.first_name).to eq(user.first_name)
    end

    it "newly created user has correct last_name" do
      expect(User.last.last_name).to eq(user.last_name)
    end

    it "newly created user has correct title" do
      expect(User.last.title).to eq(user.title)
    end

    it "newly created user has correct role" do
      expect(User.last.role).to eq(user.role)
    end

    it "newly created user has correct provider" do
      expect(User.last.provider).to eq(user.provider)
    end

    it "newly created user has correct uid" do
      expect(User.last.uid).to eq(user.uid)
    end
  end

  describe "DELETE /destroy" do
    let!(:user_one) { FactoryBot.create(:user) }
    let!(:user_two) { FactoryBot.create(:user) }
    let!(:deleted_user_name) { user_one.employee_name }

    before do
      delete "/api/v1/users/#{user_one.id}"
    end

    it "returns status code 200 (ok)" do
      expect(response).to have_http_status(:ok)
    end

    it "returns correct JSON message" do
      expect(json["message"]).to eq("#{deleted_user_name} successfully deleted")
    end

    it "the expected user to be deleted is deleted" do
      expect(User.count).to eq(1)
      expect(User.first).to eq(user_two)
    end
  end
end