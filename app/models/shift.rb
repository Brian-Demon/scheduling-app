class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validate :validate_shift

  def format_shift(type)
    type.strftime("%b %d, %Y @ %H:%M")
  end

  private

  def validate_shift
    if !user.present?
      errors.add(:user, "must be present")
    elsif !schedule.present?
      errors.add(:schedule, "must be present")
    elsif !shift_start.present?
      errors.add(:shift_start, "must be present")
    elsif !shift_end.present?
      errors.add(:shift_end, "must be present")
    elsif shift_start > shift_end
      errors.add(:shift_end, "must be after the shift start date")
    elsif shift_start < schedule.first_day
      errors.add(:shift_start, "must fall within the schedule dates")
    elsif shift_end > schedule.last_day
      errors.add(:shift_end, "must fall within the schedule dates")
    end
  end
end
