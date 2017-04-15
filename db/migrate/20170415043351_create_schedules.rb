class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :city
      t.string :state
      t.string :country
      t.datetime :time
      t.integer :activity_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
