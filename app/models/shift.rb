class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validates :schedule, presence: true
end
