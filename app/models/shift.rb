class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validate :validate_shift

  def format_shift(type)
    type.strftime("%b %d, %Y @ %H:%M")
  end

  private

  def validate_shift
    errors.add(:user, "must be present") if !user.present?
    errors.add(:schedule, "must be present") if !schedule.present?
    errors.add(:shift_start, "must be present") if !shift_start.present?
    errors.add(:shift_end, "must be present") if !shift_end.present?
    if shift_start.present? && shift_end.present?
      errors.add(:shift_end, "must be after the shift start date") if shift_start > shift_end
      errors.add(:shift_start, "must fall within the schedule dates") if schedule&.first_day.present? && shift_start < schedule.first_day
      errors.add(:shift_end, "must fall within the schedule dates") if schedule&.last_day.present? && shift_end > schedule.last_day
    end
  end
end
