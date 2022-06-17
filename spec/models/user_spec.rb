RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'returns the employee name (full name) for a user' do
    expect(user.employee_name).to eq("#{user.first_name} #{user.last_name}")
  end
end