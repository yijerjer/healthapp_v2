class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :schedule1_id, index: true
      t.integer :schedule2_id, index: true

      t.timestamps
    end
  end
end