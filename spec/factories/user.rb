require 'factory_bot'

FactoryBot.define do
  factory :user do
    email { FactoryBot.generate(:email) }
    password { "password" }
    password_confirmation { "password" }
    first_name  { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    title { 'bartender' }
    role { 'employee' }
    uid { FactoryBot.generate(:uid) }
  end
end