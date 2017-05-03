class ChangeLocationOfConfirms < ActiveRecord::Migration[5.0]
  def change
    add_column :confirms, :location, :string 
    
    remove_column :confirms, :street, :string
    remove_column :confirms, :city, :string
    remove_column :confirms, :state, :string
    remove_column :confirms, :country, :string

  end
end
