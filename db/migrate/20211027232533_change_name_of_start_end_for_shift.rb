class ChangeNameOfStartEndForShift < ActiveRecord::Migration[6.1]
  def change
    rename_column :shifts, :start, :shift_start
    rename_column :shifts, :end, :shift_end
  end
end
