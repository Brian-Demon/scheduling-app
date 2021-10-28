class AddStartAndEndToSchedule < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :first_day, :datetime
    add_column :schedules, :last_day, :datetime
  end
end
