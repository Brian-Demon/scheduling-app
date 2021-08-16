class AddAuthLevelsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :manager, :boolean
    add_column :users, :admin, :boolean
  end
end
