class AddHostToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :host, :integer
  end
end
