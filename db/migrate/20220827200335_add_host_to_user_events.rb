class AddHostToUserEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :user_events, :host, :integer
  end
end
