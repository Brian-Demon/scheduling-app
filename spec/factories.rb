require 'factory_bot'

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :uid do |n|
    "uid-#{n}"
  end

  sequence :password do |n|
    "mypassword-#{n}"
  end
end