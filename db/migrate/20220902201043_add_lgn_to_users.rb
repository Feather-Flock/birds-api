class AddLgnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lng, :float
  end
end
