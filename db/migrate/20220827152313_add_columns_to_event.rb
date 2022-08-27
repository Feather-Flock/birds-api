class AddColumnsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :address, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :zip, :integer
  end
end
