class AddRsvpsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :rsvps, :integer, default: 0 
  end
end
