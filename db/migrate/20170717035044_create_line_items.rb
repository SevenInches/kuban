class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.date :start_date
      t.date :end_date
      t.float :unit_price
      t.integer :units
      t.float :total
      t.integer :cate

      t.timestamps
    end
  end
end
