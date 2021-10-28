class AddScheduleIdToShift < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :schedule_id, :integer, null: false
  end
end
