class AddNullValueToUserIdForShifts < ActiveRecord::Migration[6.1]
  def change
    change_column :shifts, :user_id, :integer, null: false
  end
end
