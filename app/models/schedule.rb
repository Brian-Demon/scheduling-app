class Schedule < ApplicationRecord
  has_many :shifts

  validates :first_day, presence: true
  validates :last_day, presence: true

  def schedule_name
    "#{first_day.strftime("%b %d, %Y")} - #{last_day.strftime("%b %d, %Y")}"
  end
end
