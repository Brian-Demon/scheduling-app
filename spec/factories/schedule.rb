require 'factory_bot'

FactoryBot.define do
  factory :schedule do
    first_day { Date.new(2022, 8, 31) }
    last_day { Date.new(2022, 9, 7) }
  end
end