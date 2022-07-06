RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:auth) {
    {
      provider: "intuit",
      uid: "abc-123-fake-uid",
      info: {
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
      }
    }
  }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is not valid without email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is not valid without provider" do
    user.provider = nil
    expect(user).to_not be_valid
  end

  it "is not valid without uid" do
    user.uid = nil
    expect(user).to_not be_valid
  end

  it "returns the employee name (full name) for a user" do
    expect(user.employee_name).to eq("#{user.first_name} #{user.last_name}")
  end

  context "using with find_or_create_with_omniauth" do
    it "can create a user when auth is valid using create_with_omniauth" do
      new_user = User.find_or_create_with_omniauth(JSON.parse(auth.to_json))
      expect(new_user).to be_valid
    end

    it "can find a user when auth is valid using find_or_create_with_omniauth" do
      new_auth = {
        provider: user.provider,
        uid: user.uid,
        info: {
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name,
        }
      }
      new_user = User.find_or_create_with_omniauth(JSON.parse(new_auth.to_json))
      expect(new_user).to be_valid
      expect(User.count).to be(1)
      expect(new_user).to eq(user)
    end
  end
end
