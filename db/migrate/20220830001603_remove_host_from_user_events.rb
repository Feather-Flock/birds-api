class RemoveHostFromUserEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_events, :host, :integer
  end
end
