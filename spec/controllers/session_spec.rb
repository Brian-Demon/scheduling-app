require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "create" do
    before do
      OmniAuth.config.mock_auth[:intuit] = OmniAuth::AuthHash.new({
        "uid" => "1337",
        "provider" => "intuit",
        "info" => {
          "first_name" => "Test",
          "last_name" => "Person",
          "email" => "testing@example.com",
        }
      })
    end

    after do
      User.delete_all
      OmniAuth.config.mock_auth[:intuit] = nil
    end

    context "user is not already logged in" do
      before do
        get "/auth/intuit/callback"
      end

      it "can be created" do
        expect(flash[:notice]).to eq("Logged In")
      end

      it "sets login session" do
        expect(session[:user_id]).to eq(User.find_by(email: "testing@example.com").id)
      end
    end

    context "user is already logged in" do
      before do
        FactoryBot.create(:user, email: "testing@example.com", provider: "intuit", uid: 1337)
        get "/auth/intuit/callback" # set session the first time
        get "/auth/intuit/callback" # does not set session the second time
      end

      it "sets the notice" do
        expect(flash[:notice]).to eq("Already logged in")
      end
    end
    
    context "user could not be created" do
      before do 
        OmniAuth.config.mock_auth[:intuit] = OmniAuth::AuthHash.new({
          "uid" => "1337",
          "provider" => "intuit",
          "info" => {
            "first_name" => "Test",
            "last_name" => "Person",
          }
        })
        get "/auth/intuit/callback"
      end

      it "sets the notice" do
        expect(flash[:notice]).to eq("Session not created")
      end
    end
  end

  describe "destroy" do
    context "user is already logged in" do
      before do
        OmniAuth.config.mock_auth[:intuit] = OmniAuth::AuthHash.new({
          "uid" => "1337",
          "provider" => "intuit",
          "info" => {
            "first_name" => "Test",
            "last_name" => "Person",
            "email" => "testing@example.com",
          }
        })
        get "/auth/intuit/callback"
      end

      context "can be logged out" do
        before do
          delete "/logout"
          @json_response = JSON.parse(response.body)
        end

        it "should have status 200" do
          expect(response.status).to eq(200)
        end

        it "should return json response with logged_in value being false" do
          expect(@json_response["logged_in"]).to eq(false)
        end

        it "should return csrf information with json response" do
          expect(@json_response).to have_key("csrf")
        end
      end
    end
  end

  describe "is_logged_in?" do
    context "when user is logged in" do
      before do
        OmniAuth.config.mock_auth[:intuit] = OmniAuth::AuthHash.new({
          "uid" => "1337",
          "provider" => "intuit",
          "info" => {
            "first_name" => "Test",
            "last_name" => "Person",
            "email" => "testing@example.com",
          }
        })
        get "/auth/intuit/callback"
      end

      context "should return json response" do
        before do
          get "/logged_in"
          @json_response = JSON.parse(response.body)
        end
        
        it "with logged_in value being true" do
          expect(@json_response["logged_in"]).to eq(true)
        end

        it "with correct user info" do
          user_data = @json_response["user"]
          expect(user_data["id"]).to eq(User.last.id)
          expect(user_data["email"]).to eq(User.last.email)
          expect(user_data["first_name"]).to eq(User.last.first_name)
          expect(user_data["last_name"]).to eq(User.last.last_name)
          expect(user_data["title"]).to eq(User.last.title)
          expect(user_data["role"]).to eq(User.last.role)
          expect(user_data["provider"]).to eq(User.last.provider)
          expect(user_data["uid"]).to eq(User.last.uid)
        end
      end
    end

    context "when user is NOT logged in" do
      context "should return json response" do
        before do
          get "/logged_in"
          @json_response = JSON.parse(response.body)
        end

        it "with logged_in value being false" do
          expect(@json_response["logged_in"]).to eq(false)
        end

        it "with correct Session not created message" do
          expect(@json_response["message"]).to eq("Session not created")
        end
      end
    end
  end
end