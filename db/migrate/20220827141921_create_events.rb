class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.time :time
      t.date :date
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
