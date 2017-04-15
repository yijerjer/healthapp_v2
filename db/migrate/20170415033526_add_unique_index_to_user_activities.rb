class AddUniqueIndexToUserActivities < ActiveRecord::Migration[5.0]
  def change
    add_index :user_activities, [:user_id, :activity_id], unique: true
  end
end
