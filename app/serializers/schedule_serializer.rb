class ScheduleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_day, :last_day

  has_many :shifts
end
