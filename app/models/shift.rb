class Shift < ApplicationRecord
  has_one :user
  belongs_to :schedule
end
