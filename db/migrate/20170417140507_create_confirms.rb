class CreateConfirms < ActiveRecord::Migration[5.0]
  def change
    create_table :confirms do |t|
      t.integer :match_id
      t.integer :user1_id
      t.integer :user2_id
      t.integer :activity_id
      t.datetime :time
      t.string :street
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
