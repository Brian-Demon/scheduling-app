class ChangeAuthDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :manager, false
    change_column_default :users, :admin, false
  end
end
