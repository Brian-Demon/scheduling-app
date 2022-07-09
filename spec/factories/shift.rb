require 'factory_bot'

FactoryBot.define do
  factory :shift do
    user { FactoryBot.create(:user) }
    schedule { FactoryBot.create(:schedule) }
    shift_start { Time.parse("September 1, 2022 18:00") }
    shift_end { Time.parse("September 2, 2022 02:00") }
  end
end