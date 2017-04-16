class CreateScheduleResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_responses do |t|
      t.integer :responder_id
      t.integer :receiver_id
      t.integer :status

      t.timestamps
    end

    add_index :schedule_responses, [:responder_id, :receiver_id], unique: true
  end
end
