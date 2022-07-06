class ShiftSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :shift_start, :shift_end
end
