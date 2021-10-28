class AddUserIdToExclusion < ActiveRecord::Migration[6.1]
  def change
    add_column :exclusions, :user_id, :integer, null: false
  end
end
