class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validates :user, presence: true
  validates :schedule, presence: true
  validates :shift_start, presence: true
  validates :shift_end, presence: true

  def format_shift(type)
    type.strftime("%b %d, %Y @ %H:%M")
  end
end
