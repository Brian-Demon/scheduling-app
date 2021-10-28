class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validates :schedule, presence: true

  def format_shift(type)
    type.strftime("%b %d, %Y @ %H:%M")
  end
end
